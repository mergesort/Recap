import SwiftUI

/// Represents an individual feature to be displayed on the `RecapScreen`.
public struct Feature: Identifiable, Equatable {
    public let id = UUID()

    public let title: String
    public let description: String
    public let symbolName: String
    public let hexColor: String

    public init(title: String, description: String, symbolName: String, hexColor: String) {
        self.title = title
        self.description = description
        self.symbolName = symbolName
        self.hexColor = hexColor
    }
}

internal extension Feature {
    var color: Color {
        Color(hex: self.hexColor)
    }
}
