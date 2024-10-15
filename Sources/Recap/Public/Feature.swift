import SwiftUI

/// Represents an individual feature to be displayed on the `RecapScreen`.
public struct Feature: Identifiable, Equatable {
    public let id = UUID()

    public let title: String
    public let description: String
    public let symbolName: String
    public let colorDescription: String

    public init(title: String, description: String, symbolName: String, colorDescription: String) {
        self.title = title
        self.description = description
        self.symbolName = symbolName
        self.colorDescription = colorDescription
    }
}

internal extension Feature {
    var color: Color {
        if self.colorDescription.hasPrefix("#") {
            return Color(hex: self.colorDescription)
        } else if let color = ColorName(rawValue: self.colorDescription.trimmingCharacters(in: .whitespaces).lowercased())?.asColor() {
            return color
        } else {
            return .white
        }
    }
}
