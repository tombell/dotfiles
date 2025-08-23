#!/usr/bin/env bash

rcup_install() {
  local tags=()
  local extra_args=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --) shift; break ;;
      *)  tags+=("$1"); shift ;;
    esac
  done

  extra_args=("$@")

  local tag_args=()
  for tag in "${tags[@]}"; do
    tag_args+=("-t" "$tag")
  done

  echo "==> Installing dotfiles..."

  rcup -d "${HOME}/.dotfiles" \
    "${tag_args[@]}" \
    -x LICENSE -x README.md -x scripts \
    "${extra_args[@]}"
}
