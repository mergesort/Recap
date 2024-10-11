import Testing
@testable import Recap

@Suite("SemanticVersion Tests")
struct SemanticVersionTests {
    @Test("Parsing Valid Versions")
    func parsingValidVersions() {
        #expect(SemanticVersion(version: "3") == SemanticVersion(major: 3, minor: 0, patch: 0))
        #expect(SemanticVersion(version: "3.0") == SemanticVersion(major: 3, minor: 0, patch: 0))
        #expect(SemanticVersion(version: "3.0.0") == SemanticVersion(major: 3, minor: 0, patch: 0))
        #expect(SemanticVersion(version: "1.2.3") == SemanticVersion(major: 1, minor: 2, patch: 3))
        #expect(SemanticVersion(version: "10.20.30") == SemanticVersion(major: 10, minor: 20, patch: 30))
        #expect(SemanticVersion(version: "0.0.1") == SemanticVersion(major: 0, minor: 0, patch: 1))
    }

    @Test("Parsing Invalid Versions")
    func parsingInvalidVersions() {
        #expect(SemanticVersion(version: "A") == SemanticVersion(major: 0, minor: 0, patch: 0))
        #expect(SemanticVersion(version: ".") == SemanticVersion(major: 0, minor: 0, patch: 0))
        #expect(SemanticVersion(version: "1.A.3") == SemanticVersion(major: 1, minor: 0, patch: 3))
        #expect(SemanticVersion(version: "1..3") == SemanticVersion(major: 1, minor: 0, patch: 3))
        #expect(SemanticVersion(version: "") == SemanticVersion(major: 0, minor: 0, patch: 0))
    }

    @Test("Comparing Versions")
    func comparingVersions() {
        #expect(SemanticVersion(version: "1.0.0") < SemanticVersion(version: "2.0.0"))
        #expect(SemanticVersion(version: "1.9.0") < SemanticVersion(version: "1.10.0"))
        #expect(SemanticVersion(version: "1.0.9") < SemanticVersion(version: "1.0.10"))

        #expect(SemanticVersion(version: "2.0.0") > SemanticVersion(version: "1.9.9"))
        #expect(SemanticVersion(version: "1.1.0") > SemanticVersion(version: "1.0.9"))
        
        #expect(SemanticVersion(version: "1.0.0") == SemanticVersion(version: "1.0.0"))
        #expect(SemanticVersion(version: "2.1.3") == SemanticVersion(version: "2.1.3"))
    }
}
