import SwiftUI

/// Represents an individual feature to be displayed on the `RecapScreen`.
public struct Feature: Identifiable, Equatable {
    public let id = UUID()

    public let title: String
    public let description: String
    public let symbolName: String
    public let colorRepresentation: String

    public init(title: String, description: String, symbolName: String, colorRepresentation: String) {
        self.title = title
        self.description = description
        self.symbolName = symbolName
        self.colorRepresentation = colorRepresentation
    }
}

internal extension Feature {
    var color: Color {
        if self.colorRepresentation.hasPrefix("#") {
            return Color(hex: self.colorRepresentation)
        } else if let color = Color(systemName: self.colorRepresentation) {
            return color
        } else {
            return .black
        }
    }
}
