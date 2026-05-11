# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-05-07

### Added
- Swift Package Manager support (Package.swift)
- CI/CD pipeline with matrix builds (iOS + macOS)
- SwiftLint and SwiftFormat configuration
- Comprehensive unit test suite (200+ test cases)
- CHANGELOG.md, CONTRIBUTING.md

### Fixed
- AxcLockWrapper: os_unfair_lock memory safety issue (pointer allocation)
- AxcLockWrapper: Read operations now always lock (data race fix)
- AxcArraySpace.isContent: Logic error (only checked first element)
- AxcArraySpace.duplicates: Now correctly returns duplicate items
- AxcArraySpace.remove(at:): Negative index validation
- AxcArraySpace.object(reversed:by:): Uses first(where:) instead of forEach
- AxcArraySpace.index(of:): Uses firstIndex(where:) instead of forEach
- Int8/Int16/Int32 conversions: Overflow crash fixed with clamping
- String.hexData: Force unwrap replaced with safe unwrap
- String.uppercased(_:): Now correctly uppercases the character
- String.encodingType: Fixed undefined variable reference
- _AxcCGPathEx: FatalLog replaced with Log (no production crash)

### Changed
- Renamed directory `AppKit&UIKit` → `AppKitAndUIKit` (SPM compatibility)
- Property wrappers (CodableWrapper, StringValidated) changed from class to struct
- All deprecated APIs removed (project not yet released)
- File headers updated from `AxcBadrock` to `AxcBedrock`

### Removed
- All `@available(*, deprecated)` APIs
- `AxcLockWrapper.set(isUseReadLock:)` (reads always lock now)

## [1.1.4] - Previous Release

- Last CocoaPods-only release
