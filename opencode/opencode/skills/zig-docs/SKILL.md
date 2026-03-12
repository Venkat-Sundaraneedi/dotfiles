---
name: zig-docs
description: Reference official Zig language documentation for stdlib APIs, build system, and language reference. Use when working with Zig files (.zig, build.zig.zon), zig build commands, or the Zig standard library. Essential for avoiding outdated training data since Zig evolves rapidly.
compatibility: opencode
---

# Zig Documentation Helper

Use this skill whenever working with Zig code to ensure you're using current, accurate information from official docs.

## Instructions

### For Standard Library (std) Questions

1. First, resolve the Context7 library ID:
   - Use `context7_resolve-library-id` with `libraryName: "zig"` and query about Zig stdlib

2. Then query specific APIs:
   - Use `context7_query-docs` with the resolved library ID
   - Ask specific questions like "How to use std.mem.Allocator" or "std.json parsing example"

### For Build System Questions

- Fetch from: https://ziglang.org/learn/build-system/
- Topics: build.zig.zon, package management, cross-compilation

### For General/Language Reference

- Fetch from: https://ziglang.org/documentation/master/
- Topics: language syntax, keywords, builtin functions

### For Version-Specific Info

When user mentions a specific Zig version:
- Check if API exists in master docs
- Warn about potential breaking changes between versions
- Suggest checking changelogs if needed

## Best Practices

1. Always prefer Context7/std docs over training data
2. Fetch live docs for build system questions
3. Warn when APIs might have changed between versions
4. Provide actual code examples from docs, not pseudocode

## When to Use

- Working with .zig source files
- Using build.zig.zon for dependencies
- Questions about stdlib (std.fs, std.mem, std.json, etc.)
- Build configuration and compilation
- Any Zig language questions
