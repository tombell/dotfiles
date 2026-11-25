#!/usr/bin/env python3
"""Verify remote release refs and GitHub publication without mutating either."""

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path


class VerificationError(Exception):
    pass


def run_command(arguments, checkout):
    try:
        result = subprocess.run(
            arguments, cwd=checkout, text=True, capture_output=True, timeout=45
        )
    except (OSError, subprocess.TimeoutExpired) as error:
        raise VerificationError(f"{arguments[0]} could not complete: {error}") from error
    if result.returncode:
        detail = result.stderr.strip() or result.stdout.strip()
        raise VerificationError(f"{arguments[0]} failed: {detail}")
    return result.stdout


def parse_refs(output):
    refs = {}
    for line in output.splitlines():
        fields = line.split()
        if len(fields) != 2 or not re.fullmatch(r"[0-9a-fA-F]{40}|[0-9a-fA-F]{64}", fields[0]):
            raise VerificationError("Unexpected git ls-remote output")
        oid, name = fields
        if name in refs:
            raise VerificationError(f"Duplicate remote ref: {name}")
        refs[name] = oid.lower()
    return refs


def verify_refs(refs, tag, commit, branch=None):
    tag_ref = f"refs/tags/{tag}"
    if tag_ref not in refs:
        raise VerificationError(f"Missing remote tag: {tag}")
    resolved = refs.get(f"{tag_ref}^{{}}", refs[tag_ref])
    if resolved != commit:
        raise VerificationError(f"Remote tag {tag} resolves to {resolved}, expected {commit}")
    if branch:
        actual = refs.get(f"refs/heads/{branch}")
        if actual != commit:
            raise VerificationError(f"Remote branch {branch} resolves to {actual}, expected {commit}")


def normalize_body(body):
    return body.replace("\r\n", "\n").removesuffix("\n")


def verify_assets(release, names):
    assets = release.get("assets")
    if not isinstance(assets, list):
        raise VerificationError("Release response lacks an asset list")
    for name in names:
        matches = [a for a in assets if isinstance(a, dict) and a.get("name") == name]
        if not matches:
            raise VerificationError(f"Release asset {name} is missing")
        asset = matches[0]
        if asset.get("state") != "uploaded":
            raise VerificationError(f"Release asset {name} is {asset.get('state')!r}, expected 'uploaded'")
        digest = asset.get("digest")
        if not isinstance(digest, str) or not re.fullmatch(r"sha256:[0-9a-f]{64}", digest):
            raise VerificationError(f"Release asset {name} lacks a sha256 digest")


def verify_publication(release, tag, prerelease, notes):
    if not isinstance(release, dict):
        raise VerificationError("Unexpected GitHub release response")
    expected = {"tagName": tag, "name": tag, "isDraft": False, "isPrerelease": prerelease}
    for field, value in expected.items():
        actual = release.get(field)
        if type(actual) is not type(value) or actual != value:
            raise VerificationError(f"Release {field} is {actual!r}, expected {value!r}")
    if not release.get("publishedAt") or not release.get("url"):
        raise VerificationError("Release lacks a publication timestamp or URL")
    body = release.get("body")
    if not isinstance(body, str) or normalize_body(body) != normalize_body(notes):
        raise VerificationError("Published release body differs from the prepared notes")


def parse_arguments():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--checkout", type=Path, required=True)
    parser.add_argument("--remote", required=True)
    parser.add_argument("--branch", help="Require this branch to match; omit for an older tag")
    parser.add_argument("--repo", required=True, help="Verified GitHub OWNER/REPO")
    parser.add_argument("--tag", required=True)
    parser.add_argument("--commit", required=True, help="Full expected release commit ID")
    parser.add_argument("--notes-file", type=Path, required=True)
    parser.add_argument("--asset", action="append", default=[],
                        help="Require this uploaded release asset; repeatable")
    channel = parser.add_mutually_exclusive_group(required=True)
    channel.add_argument("--prerelease", action="store_true")
    channel.add_argument("--stable", action="store_true")
    args = parser.parse_args()
    if not args.checkout.is_dir():
        parser.error("--checkout must be an existing directory")
    if not re.fullmatch(r"[0-9a-fA-F]{40}|[0-9a-fA-F]{64}", args.commit):
        parser.error("--commit must be a full 40- or 64-character hexadecimal commit ID")
    if not re.fullmatch(r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+", args.repo):
        parser.error("--repo must use OWNER/REPO format")
    for name in (args.remote, args.tag, args.branch):
        if name is not None and (not name or name.startswith("-") or any(c.isspace() for c in name)):
            parser.error("Remote and ref names must be nonempty, without leading '-' or whitespace")
    args.commit = args.commit.lower()
    return args


def main():
    args = parse_arguments()
    try:
        notes = args.notes_file.read_text(encoding="utf-8")
        if not notes.strip():
            raise VerificationError("Prepared notes are empty")
        ref_names = [f"refs/tags/{args.tag}", f"refs/tags/{args.tag}^{{}}"]
        if args.branch:
            ref_names.append(f"refs/heads/{args.branch}")
        refs = parse_refs(run_command(["git", "ls-remote", args.remote, *ref_names], args.checkout))
        verify_refs(refs, args.tag, args.commit, args.branch)
        raw = run_command(
            ["gh", "release", "view", args.tag, "--repo", args.repo, "--json",
             "tagName,name,isDraft,isPrerelease,publishedAt,body,url,assets"], args.checkout
        )
        release = json.loads(raw)
        verify_publication(release, args.tag, args.prerelease, notes)
        verify_assets(release, args.asset)
    except (VerificationError, OSError, UnicodeError, json.JSONDecodeError) as error:
        print(f"Verification failed: {error}", file=sys.stderr)
        return 1
    print(f"Verified {args.repo} {args.tag} at {args.commit}")
    print(release["url"])
    return 0


if __name__ == "__main__":
    sys.exit(main())
