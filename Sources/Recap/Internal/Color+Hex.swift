import SwiftUI

internal extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        let length = hexString.count

        guard Scanner(string: hexString).scanHexInt64(&rgb) else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
            return
        }

        if length == 3 {
            r = CGFloat((rgb & 0xF00) >> 8) / 15.0
            g = CGFloat((rgb & 0x0F0) >> 4) / 15.0
            b = CGFloat(rgb & 0x00F) / 15.0
        } else if length == 4 {
            r = CGFloat((rgb & 0xF000) >> 12) / 15.0
            g = CGFloat((rgb & 0x0F00) >> 8) / 15.0
            b = CGFloat((rgb & 0x00F0) >> 4) / 15.0
            a = CGFloat(rgb & 0x000F) / 15.0
        } else if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
            return
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }

    var hex: String {
#if os(iOS) || os(watchOS)
        let components = UIColor(self).cgColor.components
#elseif os(macOS)
        let components = NSColor(self).cgColor.components
#endif
        let red: CGFloat = components?[0] ?? 0.0
        let green: CGFloat = components?[1] ?? 0.0
        let blue: CGFloat = components?[2] ?? 0.0
        let alpha: CGFloat = components?[3] ?? 1.0

        let hexRange: (_ input: CGFloat) -> Int = { input in
            lroundf(Float(input * 255))
        }

        return String(format: "#%02lX%02lX%02lX%02lX", hexRange(red), hexRange(green), hexRange(blue), hexRange(alpha))
    }

}

