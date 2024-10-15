import SwiftUI

/// A string-convertible representation of a system color.
enum ColorName: String, CaseIterable, Sendable {
    case black
    case blue
    case brown
    case cyan
    case gray
    case green
    case indigo
    case mint
    case orange
    case pink
    case purple
    case red
    case teal
    case white
    case yellow

    func asColor() -> Color {
        switch self {
        case .black: return .black
        case .blue: return .blue
        case .brown: return .brown
        case .cyan: return .cyan
        case .gray: return .gray
        case .green: return .green
        case .indigo: return .indigo
        case .mint: return .mint
        case .orange: return .orange
        case .pink: return .pink
        case .purple: return .purple
        case .red: return .red
        case .teal: return .teal
        case .white: return .white
        case .yellow: return .yellow
        }
    }
}
