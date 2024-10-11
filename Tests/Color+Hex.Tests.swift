import Testing
import SwiftUI
@testable import Recap

@Suite("Color Hex Tests")
struct ColorHexTests {
    @Test("Three Digit Hex")
    func validateThreeDigitHexValues() {
        let color = Color(hex: "#F00")
        #expect(color.hex == "#FF0000FF")
    }
    
    @Test("Four Digit Hex")
    func validateFourDigitHexValues() {
        let color = Color(hex: "#F00F")
        #expect(color.hex == "#FF0000FF")
    }
    
    @Test("Six Digit Hex")
    func validateSixDigitHexValues() {
        let color = Color(hex: "#00FF00")
        #expect(color.hex == "#00FF00FF")
    }
    
    @Test("Eight Digit Hex")
    func validateEightDigitHexValues() {
        let color = Color(hex: "#0000FF80")
        #expect(color.hex == "#0000FF80")
    }
    
    @Test("Hex Without Hash")
    func validatetHexValuesWithoutHash() {
        let color = Color(hex: "FF0000")
        #expect(color.hex == "#FF0000FF")
    }
    
    @Test("Invalid Hex")
    func validateInvalidHexValues() {
        let color = Color(hex: "INVALID")
        #expect(color.hex == "#FFFFFFFF")
    }
    
    @Test("Empty String")
    func validateEmptyString() {
        let color = Color(hex: "")
        #expect(color.hex == "#FFFFFFFF")
    }
    
    @Test("Lowercase Hex")
    func validateLowercaseHexValues() {
        let color = Color(hex: "#00ff00")
        #expect(color.hex == "#00FF00FF")
    }
    
    @Test("Mixed Case Hex")
    func validateMixedDigitHexValues() {
        let color = Color(hex: "#00Ff00")
        #expect(color.hex == "#00FF00FF")
    }
}
