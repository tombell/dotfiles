---
name: starkwm-swift-test-conventions
description: Apply StarkWM Swift Testing conventions when adding or reviewing tests, or standardizing suite labels, test names, and test order. Align tests with production types and declarations while preserving behavior.
---

# StarkWM Swift test conventions

Read the production declarations and existing tests before naming or moving tests. Inspect applicable repository instructions, the Makefile, and working-copy changes. Preserve existing user edits.

## Suites and names

- Give each tested production type its own suite, labeled with its type name, such as `@Suite("ConfigurationFile")`. Use the established test type name, normally `ConfigurationFileTests`.
- Keep tests for substantial production types in separate files. Split files that mix unrelated tested types; keep shared fixtures where the checkout already places them.
- Give every test a descriptive `@Test` label in the form `<member or thing>: <conditions>`. Use the actual member name, including argument labels where they clarify overloads.
- Keep Swift function names short and readable. The display label can carry the detailed condition.

For example:

```swift
@Suite("ConfigurationStore")
struct ConfigurationStoreTests {
  @Test("reload(ifChanged:validate:): preserves settings after an invalid file")
  func preservesSettingsAfterInvalidFile() throws {
    // Existing test implementation.
  }
}
```

## Order and spacing

- Order tests by the corresponding production declaration order. Group multiple cases for the same member together. Treat members implemented in extensions as part of the tested type, following the checkout's source organization.
- Label parser, helper, initializer, and computed-property tests for the actual declaration or behavior they cover. Do not force every test under a command type when it tests a separate helper.
- Use blank lines between logical setup, validation, action, polling, and assertion blocks. Follow the repository formatter and Swift declaration-order conventions.

## Preserve useful coverage

For a naming or ordering pass, retain the test inputs, assertions, isolation, and behavior. Do not add production helpers just to support reorganizing tests, or remove coverage as part of cosmetic cleanup.

For new async tests, make sure every path can terminate. Finish owned AsyncStream producers on exit and use bounded waits when consuming events. Recording an issue alone does not unblock a suspended consumer. Preserve cancellation checks and the checkout's existing timeout helpers.

## Validate

Review moved test blocks against their production types, then format changed test files and run the checkout's lint and test commands. Do not run a repository-wide formatter over unrelated user edits. Keep the Makefile's test flags, including its parallelism setting.

If execution restrictions block caches or required system access, diagnose them before treating the result as a regression. Report checks that remain unverified. Use captured command output for any reported test counts.

Report the suites or files changed and validation results. Commit and push only when requested, preserving the scope of the test work.
