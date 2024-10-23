import Testing
import SwiftUI
@testable import Recap

@Suite("System Color Tests")
struct SystemColorTests {
    @Test("Validate known colors", arguments: [
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
    func validateKnownColors(colorString: String) {
        #expect(Color(systemName: colorString) != nil)
    }

    @Test("Validate colors with varying casing and spacing issues", arguments: [
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
    func validateColorsWithInconsistencies(colorString: String) {
        #expect(Color(systemName: colorString) != nil)
    }

    @Test("Validate unknown colors", arguments: [
        "aquamarine",
        "vantablack",
    ])
    func validateUnknownColors(colorString: String) {
        #expect(Color(systemName: colorString) == nil)
    }
}
