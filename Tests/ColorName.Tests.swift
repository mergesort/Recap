import Testing
import SwiftUI
@testable import Recap

@Suite("Color Name Tests")
struct ColorNameTests {

    @Test("Valid colors", arguments: [
        "black",
        "blue",
        "brown",
        "cyan",
        "gray",
        "green",
        "indigo",
        "mint",
        "orange",
        "pink",
        "purple",
        "red",
        "teal",
        "white",
        "yellow",
    ])
    func validColors(colorString: String) {
        #expect(ColorName(rawValue: colorString) != nil)
    }

    @Test("Unknown colors", arguments: [
        "aquamarine",
        "vantablack",
    ])
    func unknownColors(colorString: String) {
        #expect(ColorName(rawValue: colorString) == nil)
    }

    @Test("Valid colors with weird casing and spacing", arguments: [
        "Black",
        "Blue ",
        "Brown ",
        "CYAN",
        " graY",
        " grEEn",
        " indiGo",
        "miNt",
        "oranGe",
        "Pink",
        "Purple ",
        "Red",
        "Teal",
        "White",
        "Yellow",
    ])
    func validColorsWithWeirdness(colorString: String) {
        #expect(ColorName(rawValue: colorString) == nil)
    }
}
