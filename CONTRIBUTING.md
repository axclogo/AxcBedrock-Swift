# Contributing to AxcBedrock

Thank you for your interest in contributing to AxcBedrock!

## Development Setup

1. Clone the repository
2. Open `AxcBedrock.xcworkspace` or use SPM: `swift build`
3. Run tests: `swift test`

## Code Style

- Follow the existing namespace pattern (`.axc` / `.Axc`)
- Use `// MARK: -` sections in every file
- All public APIs must have `///` documentation comments
- Use `AxcUnifiedNumber` and other Unified types for flexible parameters
- Never use `as!` force cast — use `as?` with fallback
- Never use `fatalError` / `FatalLog` in non-DEBUG builds

## Pull Request Process

1. Create a feature branch from `develop`
2. Ensure all tests pass: `swift test`
3. Run SwiftLint: `swiftlint lint`
4. Update CHANGELOG.md
5. Submit PR with clear description

## Naming Conventions

- Files: `Axc{TypeName}Ex.swift`
- Classes/Protocols: PascalCase with `Axc` prefix
- Factory methods: `Create(xxx:)` (non-optional), `CreateOptional(xxx:)` (optional)
- Boolean properties: `is`/`has`/`can` prefix

## Constraints

- No third-party dependencies
- Minimum deployment: iOS 10.0 / macOS 11.0
- Must compile on both iOS and macOS targets
