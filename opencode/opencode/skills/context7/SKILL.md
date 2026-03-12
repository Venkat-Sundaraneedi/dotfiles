---
name: context7
description: Use Context7 MCP to access up-to-date library documentation when working with project dependencies. Always consult Context7 for accurate API references, patterns, and examples when doing in-depth work with libraries.
compatibility: opencode
---

# Context7 Library Documentation

## Overview

This skill provides access to up-to-date, version-specific documentation for libraries through the Context7 MCP server. Instead of relying on potentially outdated training data, use Context7 to fetch current documentation, API references, and code examples directly from library sources.

This skill works with **any programming language** - Rust, Python, Go, JavaScript, TypeScript, Java, C++, Ruby, PHP, Elixir, and more.

## When to Use Context7

**ALWAYS use Context7 when:**
- Implementing new features with any library
- Debugging library-specific issues or errors
- Understanding correct API usage or patterns
- Working with version-specific features
- Needing code examples for library functionality
- Uncertain about current best practices for a library

**Before starting significant work** with any library, use Context7 to:
1. Verify current API patterns and signatures
2. Get version-specific documentation
3. Find official code examples and best practices
4. Understand breaking changes or deprecations

## How to Use Context7 MCP

### Step 1: Resolve Library ID

Before fetching documentation, resolve the library ID (if not already known):

```
Use the OpenCode tool: context7_resolve-library-id
Arguments: { "libraryName": "axum", "query": "rust web framework routing and middleware" }
```

This returns the exact Context7-compatible library ID and available versions.

### Step 2: Fetch Documentation

Once you have the library ID, fetch documentation for your specific use case:

```
Use the OpenCode tool: context7_query-docs
Arguments: {
  "libraryId": "/tokio-rs/axum",
  "query": "routing, handlers and extractors"
}
```

**Recommended token ranges:**
- Quick reference: 2000-3000 tokens
- Feature implementation: 5000-8000 tokens
- Complex patterns: 8000-12000 tokens

### Step 3: Apply Documentation

Use the fetched documentation to:
1. Verify API signatures and patterns
2. Follow current best practices
3. Implement features correctly
4. Avoid deprecated patterns

## Workflow Examples

### Example 1: Implementing Rust Web Framework Features

```
1. Resolve library ID: context7_resolve-library-id("axum", "rust web framework")
2. Fetch docs: context7_query-docs("/tokio-rs/axum", "routing, handlers and extractors")
3. Review documentation for current patterns
4. Implement features following docs
5. If errors occur, fetch more specific docs about the error
```

### Example 2: Configuring Python Backend Middleware

```
1. Resolve library ID: context7_resolve-library-id("fastapi", "python async web framework")
2. Fetch docs: context7_query-docs("/tiangolo/fastapi", "middleware and CORS configuration")
3. Review middleware patterns and configuration
4. Implement middleware based on official examples
5. Verify implementation matches current best practices
```

### Example 3: Using Rust Validation Libraries

```
1. Resolve library ID: context7_resolve-library-id("validator", "rust validation crate")
2. Fetch docs: context7_query-docs("/derive-validator/validator", "custom validators and validation traits")
3. Review validator patterns
4. Implement validators following docs
5. Validate integration with web framework patterns
```

### Example 4: Working with Go Libraries

```
1. Resolve library ID: context7_resolve-library-id("gin", "go web framework")
2. Fetch docs: context7_query-docs("/gin-gonic/gin", "routing and middleware")
3. Review Go-specific patterns
4. Implement features following docs
```

### Example 5: Using JavaScript/TypeScript Libraries

```
1. Resolve library ID: context7_resolve-library-id("prisma", "orm for nodejs")
2. Fetch docs: context7_query-docs("/prisma/prisma", "schema and queries")
3. Review TypeScript types and Query API
4. Implement database operations following docs
```

## Best Practices

### 1. Always Fetch First for New Features

Before implementing any significant feature with a library, fetch Context7 docs to ensure you're using current patterns and APIs.

### 2. Use Specific Topics

Be specific in your query parameter:
- ✅ "routing, handlers and extractors"
- ✅ "async traits and error handling"
- ✅ "middleware and authentication"
- ❌ "help" (not specific)
- ❌ "docs" (too broad)

### 3. Verify Version Compatibility

When fetching docs, note the version returned and compare with your lockfile version. Request specific versions if needed:
```
libraryId: "/tokio-rs/axum/v0.7.0"
```

### 4. Cache Common Patterns Mentally

After fetching docs for a common pattern, remember the key insights for similar use cases. Re-fetch if uncertain or if significant time has passed.

### 5. Combine Multiple Sources for Complex Features

For features spanning multiple libraries (e.g., web framework + ORM + auth), fetch docs for each relevant library.

### 6. Use Context7 for Error Resolution

When encountering library-specific errors:
1. Identify the specific library causing the error
2. Fetch docs with the error message or feature as the query
3. Review breaking changes or migration guides
4. Apply fixes based on current documentation

## Integration with Development Workflow

### Planning Phase
- Identify all libraries involved in the feature
- Resolve Context7 IDs for each library
- Fetch high-level documentation for architecture planning

### Implementation Phase
- Fetch detailed docs for specific APIs and patterns
- Reference examples and code snippets
- Verify type signatures and function parameters

### Debugging Phase
- Fetch docs about error-related features
- Review troubleshooting sections
- Check for known issues or breaking changes

### Code Review Phase
- Verify implementations match current best practices
- Check for deprecated patterns
- Ensure version compatibility

## Troubleshooting

### Library ID Not Found
If `context7_resolve-library-id` doesn't find a library:
1. Try alternative names (e.g., "axum" vs "axum web framework")
2. Try organization name (e.g., "tokio-rs/axum")
3. Search for the library on GitHub to find the org/repo structure
4. For custom/vendored libraries, skip Context7 and use code directly

### Documentation Too Broad
If returned docs are too general:
1. Make query more specific
2. Include the exact API or feature name
3. Mention the use case in the query

### Version Mismatch
If the version in Context7 differs from your lockfile:
1. Request specific version: `/org/lib/v1.2.3`
2. Check if patterns still apply to your version
3. Consult CHANGELOG for breaking changes
4. Consider updating the library if feasible

## Available Tools

OpenCode provides these Context7 MCP tools:

- **context7_resolve-library-id**: Resolve a library name to Context7-compatible library ID
  - `libraryName`: The name of the library (e.g., "axum", "next.js", "pandas")
  - `query`: What you need help with (optional, improves results)

- **context7_query-docs**: Query library documentation
  - `libraryId`: The Context7 library ID (e.g., "/tokio-rs/axum")
  - `query`: The specific topic or feature you need docs for

## Summary

This skill ensures you always have access to current, accurate library documentation when building features. By proactively using Context7, you reduce bugs, follow best practices, and implement features correctly the first time.

**Remember**: When in doubt about any library API, pattern, or feature, fetch Context7 docs before implementing.
