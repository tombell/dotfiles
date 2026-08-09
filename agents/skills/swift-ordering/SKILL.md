---
name: swift-ordering
description: Apply the user's preferred declaration ordering in Swift source files. Use when creating, reorganizing, or reviewing .swift files, including SwiftUI views and previews. Covers access-control order, file-level declarations, type members, extensions, supplementary types, and preview-only types.
---

# Swift Ordering

Use this skill as the declaration-ordering style guide for Swift files. Apply it when writing new Swift or when the user asks to organize, tidy, or review existing Swift.

Ordering changes must remain behavior-preserving. Do not rename declarations, change APIs, split or merge extensions, or otherwise refactor code merely to satisfy this guide.

## Access control

Within each comparable declaration group, order declarations from broadest to narrowest access:

1. `public`
2. internal declarations, with the `internal` keyword omitted
3. `fileprivate`
4. `private`

Treat the structural sections below as the primary order and access control as the order within a section. For example, a private type alias still belongs in the type-alias section rather than after methods.

Do not add an explicit `internal` modifier. Remove it when it is only spelling the default and doing so cannot affect generated code or tooling. If a file uses access levels not covered here, such as `open` or `package`, follow the project's established placement rather than inventing a new convention.

## File-level order

Keep imports and file header material at the top. Then use this order:

1. Global type aliases
2. Global variables and constants
3. Global functions
4. Main type for the file
5. Extensions of the main type
6. Supplementary types and their extensions
7. SwiftUI preview-only view types and preview declarations

The main type is normally the declaration named after the file or the principal declaration the file exists to define. Keep all extensions of that type after its primary declaration and before supplementary types.

## Member order within a type

Use this order inside the main type:

1. Type aliases
2. Nested type definitions
3. Static and class variables or constants
4. Static and class methods
5. `public` and internal instance variables or constants
6. SwiftUI `body`
7. `fileprivate` and `private` instance variables or constants
8. Initializers
9. Deinitializer
10. Instance methods

Apply the same member order to extensions and supplementary types where it fits their contents.

### SwiftUI `body`

For a SwiftUI `View`, place `body` after the view's ordinary public/internal state and configuration properties, but before `fileprivate` or `private` implementation-detail properties. This is an explicit exception to treating all instance properties as one uninterrupted block. For non-SwiftUI types, keep all instance properties together and apply the normal access-control order.

### Classification

- Group both `let` and `var` as variables/constants.
- Group computed properties with other properties.
- Group `class` members with the corresponding `static` section.
- Group subscripts and operators with methods unless the surrounding project has a stronger convention.
- Keep overloads and closely related declarations together within their appropriate section.
- For enum cases, protocol requirements, associated types, and other declarations not explicitly listed, use the nearest semantic section and preserve coherent existing groups.

## Extensions and supplementary declarations

Keep each protocol-conformance extension cohesive. Order members inside it using the rules above, but do not move required conformance members out of the extension just to create a file-wide member grouping.

Supplementary declarations include helper protocols, structs, classes, enums, actors, and other types that support the main type. Place a supplementary type's own extensions with that type, while keeping the entire supplementary section after all extensions of the main type.

Keep preview-only helper views at the end of the file. Place `#Preview` declarations after any preview helper types they use. Preserve `#if DEBUG` or availability wrappers around preview code.

## Reordering workflow

1. Read the complete file before moving declarations.
2. Identify the main type and classify every top-level declaration and member.
3. Apply structural order first, then access-control order within each comparable group.
4. Preserve intentional semantic groupings when separating them would make the code less clear.
5. Move attached documentation, comments, attributes, property wrappers, and compiler directives with their declarations.
6. Treat conditional-compilation blocks as units unless each branch can be reordered safely.
7. Keep the diff limited to ordering and any necessary whitespace cleanup.
8. Run the project's formatter, linter, build, or tests when available.

Do not add `MARK:` comments solely because sections exist in this guide. Preserve and update existing section comments when declarations move. If the requested ordering is ambiguous and would produce a substantial or surprising rewrite, ask before proceeding.
