import Foundation

/// Semantic versioning is a scheme that uses a three-part version number to compare different versions of a dependency or application.
/// https://semver.org
///
/// The format is typically represented as MAJOR.MINOR.PATCH, where:
/// - MAJOR version increments for incompatible API changes.
/// - MINOR version increments for backwards-compatible functionality additions.
/// - PATCH version increments for backwards-compatible bug fixes.
/// - Note: Additional components such as prerelease identifiers are not supported.
///
/// This implementation conforms to the `Comparable` protocol, allowing for easy comparison
/// between different semantic versions.
///
/// Usage:
/// ```
/// let version = SemanticVersion(major: 1, minor: 2, patch: 3)
/// let version2 = SemanticVersion(version: "1.2.3")
/// return version == version2
/// ```
public struct SemanticVersion {
    public let major: Int
    public let minor: Int
    public let patch: Int

    public init(major: Int, minor: Int, patch: Int) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    public init(version: String) {
        let semanticVersionComponents = version.components(separatedBy: ".")

        let major = semanticVersionComponents.count > 0 ? Int(semanticVersionComponents[0]) ?? 0 : 0
        let minor = semanticVersionComponents.count > 1 ? Int(semanticVersionComponents[1]) ?? 0 : 0
        let patch = semanticVersionComponents.count > 2 ? Int(semanticVersionComponents[2]) ?? 0 : 0

        self = SemanticVersion(major: major, minor: minor, patch: patch)
    }
}

extension SemanticVersion: Comparable {
    public static func < (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        if lhs.major != rhs.major {
            return lhs.major < rhs.major
        } else if lhs.minor != rhs.minor {
            return lhs.minor < rhs.minor
        } else {
            return lhs.patch < rhs.patch
        }
    }

    public static func == (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch == rhs.patch
    }
}
