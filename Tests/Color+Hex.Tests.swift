import XCTest
import SwiftUI
@testable import Recap

final class ColorHexTests: XCTestCase {
    func testThreeDigitHex() {
        let color = Color(hex: "#F00")
        XCTAssertEqual(color.hex, "#FF0000FF")
    }
    
    func testFourDigitHex() {
        let color = Color(hex: "#F00F")
        XCTAssertEqual(color.hex, "#FF0000FF")
    }
    
    func testSixDigitHex() {
        let color = Color(hex: "#00FF00")
        XCTAssertEqual(color.hex, "#00FF00FF")
    }
    
    func testEightDigitHex() {
        let color = Color(hex: "#0000FF80")
        XCTAssertEqual(color.hex, "#0000FF80")
    }
    
    func testHexWithoutHash() {
        let color = Color(hex: "FF0000")
        XCTAssertEqual(color.hex, "#FF0000FF")
    }
    
    func testInvalidHex() {
        let color = Color(hex: "INVALID")
        XCTAssertEqual(color.hex, "#FFFFFFFF")
    }
    
    func testEmptyString() {
        let color = Color(hex: "")
        XCTAssertEqual(color.hex, "#FFFFFFFF")
    }
    
    func testLowercaseHex() {
        let color = Color(hex: "#00ff00")
        XCTAssertEqual(color.hex, "#00FF00FF")
    }
    
    func testMixedCaseHex() {
        let color = Color(hex: "#00Ff00")
        XCTAssertEqual(color.hex, "#00FF00FF")
    }
}
