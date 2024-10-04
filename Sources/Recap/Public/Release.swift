import SwiftUI
/// A `Release` is displayed on the `RecapScreen`, representing the `AppVersion`, title, and the release's features.
public struct Release: Identifiable, Equatable {
    public let version: AppVersion
    public let title: String
    public let features: [Feature]

    public init(version: AppVersion, title: String, features: [Feature]) {
        self.version = version
        self.title = title
        self.features = features
    }

    public var id: String {
        self.version.string
    }
}
