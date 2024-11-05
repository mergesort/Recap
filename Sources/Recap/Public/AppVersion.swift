import Foundation

/// `AppVersion` represents a version of an app, as it will be displayed on the `RecapScreen`.
///
/// - The `string` will be used as the unique identifier for a `Release`, to only display a release once.
/// - The `change` property is useful metadata, for example when creating logic to only present a RecapScreen when there is a major or minor change.
public struct AppVersion: Equatable {
    public let string: String
    public let change: Change

    public init(string: String, change: Change) {
        self.string = string
        self.change = change
    }
}

public extension AppVersion {
    /// Represents the type of change for a version update.
    ///
    /// Defines the three standard levels of semantic versioning:
    /// - Major: Suggested for incompatible API changes.
    /// - Minor: Suggested for functionality added in a backwards-compatible manner.
    /// - Patch: Suggested for backwards-compatible bug fixes.
    @frozen
    enum Change: Equatable {
        case major
        case minor
        case patch
    }
}

internal extension AppVersion.Change {
    init(_ string: String) {
        switch string.lowercased() {
        case "major": self = .major
        case "minor": self = .minor
        case "patch": self = .patch
        default: self = .patch
        }
    }
}
