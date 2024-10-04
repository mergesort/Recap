import XCTest
@testable import Recap

final class ReleasesParserTests: XCTestCase {
    func testParsingValidMarkdown() {
        let markdown = """
        # 1.0.0
        ## Initial Release
        ### major
        
        - title: New Feature
        - description: This is a new feature
        - symbol: star
        - color: #FF0000
        
        - title: Another Feature
        - description: This is another feature
        - symbol: cloud
        - color: #00FF00
        """

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        XCTAssertEqual(releases.count, 1)
        XCTAssertEqual(releases[0].version.string, "1.0.0")
        XCTAssertEqual(releases[0].title, "Initial Release")
        XCTAssertEqual(releases[0].version.change, .major)
        XCTAssertEqual(releases[0].features.count, 2)

        XCTAssertEqual(releases[0].features[0].title, "New Feature")
        XCTAssertEqual(releases[0].features[0].description, "This is a new feature")
        XCTAssertEqual(releases[0].features[0].symbolName, "star")
        XCTAssertEqual(releases[0].features[0].hexColor, "#FF0000")

        XCTAssertEqual(releases[0].features[1].title, "Another Feature")
        XCTAssertEqual(releases[0].features[1].description, "This is another feature")
        XCTAssertEqual(releases[0].features[1].symbolName, "cloud")
        XCTAssertEqual(releases[0].features[1].hexColor, "#00FF00")
    }

    func testParsingMultipleReleases() {
        let markdown = """
        # 2.0.0
        ## Major Update
        ### major
        
        - title: Breaking Change
        - description: This is a breaking change
        - symbol: exclamationmark.triangle
        - color: FF0000
        
        # 1.1.0
        ## Minor Update
        ### minor
        
        - title: New Feature
        - description: This is a new feature
        - symbol: star
        - color: 00FF00
        """

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        XCTAssertEqual(releases.count, 2)
        XCTAssertEqual(releases[0].version.string, "1.1.0")
        XCTAssertEqual(releases[1].version.string, "2.0.0")
    }

    func testParsingWithMissingOptionalFields() {
        let markdown = """
        # 1.0.0
        ## Initial Release
        ### patch
        
        - title: Basic Feature
        - description: This is a basic feature
        """

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        XCTAssertEqual(releases.count, 1)
        XCTAssertEqual(releases[0].features[0].symbolName, "heart")
        XCTAssertEqual(releases[0].features[0].hexColor, "#000000")
    }

    func testParsingWithEscapeSequences() {
        let markdown = """
        # 1.0.0
        ## Test Release
        ### minor
        
        - title: Feature with Escapes
        - description: This feature has a \\n newline and a \\\\ backslash
        """

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        XCTAssertEqual(releases[0].features[0].description, "This feature has a \n newline and a \\ backslash")
    }

    func testParseEmptyMarkdown() {
        let markdown = ""

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        XCTAssertTrue(releases.isEmpty)
    }
}

