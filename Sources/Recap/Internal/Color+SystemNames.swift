import SwiftUI

extension Color {
    init?(systemName: String) {
        let sanitizedColorName = systemName
            .trimmingCharacters(in: .whitespaces)
            .lowercased()

        switch sanitizedColorName {
        case "accent": self = .accentColor
        case "black": self = .black
        case "blue": self = .blue
        case "brown": self = .brown
        case "cyan": self = .cyan
        case "gray": self = .gray
        case "green": self = .green
        case "indigo": self = .indigo
        case "mint": self = .mint
        case "orange": self = .orange
        case "pink": self = .pink
        case "primary": self = .primary
        case "purple": self = .purple
        case "secondary": self = .secondary
        case "red": self = .red
        case "teal": self = .teal
        case "white": self = .white
        case "yellow": self = .yellow
        default: return nil
        }
    }
}
