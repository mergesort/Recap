import SwiftUI

/// Represents an individual feature to be displayed on the `RecapScreen`.
public struct Feature: Identifiable, Equatable {
    public let id = UUID()

    public let title: String
    public let description: String
    public let symbolName: String
    public let hexColor: String
    public let zAlignment: Alignment
    public let hAlignment: VerticalAlignment

    public init(title: String, description: String, symbolName: String, hexColor: String, alignment: String) {
        self.title = title
        self.description = description
        self.symbolName = symbolName
        self.hexColor = hexColor
        
        if alignment == "top" {
            self.zAlignment = .top
            self.hAlignment = .top
        } else if alignment == "bottom" {
            self.zAlignment = .bottom
            self.hAlignment = .bottom
        } else {
            self.zAlignment = .center
            self.hAlignment = .center
        }
    }
}

internal extension Feature {
    var color: Color {
        Color(hex: self.hexColor)
    }
}
