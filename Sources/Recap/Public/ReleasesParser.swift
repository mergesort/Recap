import Foundation

/// A parser for converting Markdown-formatted release notes into structured `Release` objects.
///
/// This struct provides functionality to parse release notes written in a specific Markdown format
/// and convert them into an array of `Release` objects. Each `Release` object represents a version
/// of the application, including its features and other metadata.
///
/// The expected Markdown format is as follows:
/// ```markdown
/// # 1.0.0
/// ## Version Title
/// ### major
///
/// #### Feature Title
/// Feature description
/// - symbol: swift
/// - color: FF0000
/// ```
///
/// Usage:
/// ```swift
/// let parser = ReleasesParser(bundle: .main, fileName: "ReleaseNotes")
/// let releases = parser.releases
/// ```
///
/// You can also initialize the parser with a Markdown string directly:
/// ```swift
/// let markdownString = "# 1.0.0\n## Initial Release\n### major\n\n#### New Feature\nDescription of the new feature"
/// let parser = ReleasesParser(markdown: markdownString)
/// let releases = parser.releases
/// ```
public struct ReleasesParser {
    let markdown: String

    public init(bundle: Bundle = Bundle.main, fileName: String) {
        self.markdown = Self.readMarkdownFile(bundle: bundle, fileName: fileName) ?? ""
    }

    public init(markdown: String) {
        self.markdown = markdown
    }

    public var releases: [Release] {
        self.parseMarkdown(self.markdown).reversed()
    }
}

private extension ReleasesParser {
    func parseMarkdown(_ markdown: String) -> [Release] {
        let lines = markdown.components(separatedBy: .newlines)

        var releases: [Release] = []
        var currentFeatures: [Feature] = []
        var currentRelease: (version: String, title: String, type: String)?
        var currentFeature: (title: String, description: String, symbol: String?, color: String?)?

        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)

            if let version = self.parseVersion(trimmedLine) {
                self.finalizeFeature(&currentFeatures, &currentFeature)
                self.finalizeRelease(&releases, &currentRelease, &currentFeatures)
                currentRelease = (version, "", "")
            } else if let versionTitle = self.parseVersionTitle(trimmedLine) {
                currentRelease?.title = versionTitle
            } else if let changeType = self.parseChangeType(trimmedLine) {
                currentRelease?.type = changeType
            } else if let title = self.parseTitle(trimmedLine) {
                self.finalizeFeature(&currentFeatures, &currentFeature)
                currentFeature = (Self.parseEscapeSequences(title), "", nil, nil)
            } else if let description = self.parseDescription(trimmedLine) {
                currentFeature?.description = Self.parseEscapeSequences(description)
            } else if let symbolName = self.parseSymbol(trimmedLine) {
                currentFeature?.symbol = symbolName
            } else if let color = self.parseColor(trimmedLine) {
                currentFeature?.color = color
            }
        }

        self.finalizeFeature(&currentFeatures, &currentFeature)
        self.finalizeRelease(&releases, &currentRelease, &currentFeatures)

        return releases
    }

    func parseVersion(_ line: String) -> String? {
        self.parseToken(line, token: "# ")
    }

    func parseVersionTitle(_ line: String) -> String? {
        self.parseToken(line, token: "## ")
    }

    func parseChangeType(_ line: String) -> String? {
        self.parseToken(line, token: "### ")
    }

    func parseDescription(_ line: String) -> String? {
        self.parseToken(line, token: "- description: ")
    }

    func parseTitle(_ line: String) -> String? {
        self.parseToken(line, token: "- title: ")
    }

    func parseSymbol(_ line: String) -> String? {
        self.parseToken(line, token: "- symbol: ")
    }

    func parseColor(_ line: String) -> String? {
        self.parseToken(line, token: "- color: ")
    }

    func parseToken(_ line: String, token: String) -> String? {
        if line.starts(with: token) {
            return String(line.dropFirst(token.count))
        } else {
            return nil
        }
    }

    private func finalizeFeature(_ features: inout [Feature], _ currentFeature: inout (title: String, description: String, symbol: String?, color: String?)?) {
        if let feature = currentFeature {
            features.append(
                Feature(
                    title: feature.title,
                    description: feature.description,
                    symbolName: feature.symbol ?? "heart",
                    hexColor: feature.color ?? "#000000"
                )
            )
            currentFeature = nil
        }
    }

    func finalizeRelease(_ releases: inout [Release], _ currentRelease: inout (version: String, title: String, type: String)?, _ features: inout [Feature]) {
        if let release = currentRelease, !features.isEmpty {
            let version = AppVersion(
                string: release.version,
                change: AppVersion.Change(release.type)
            )

            releases.append(
                Release(
                    version: version,
                    title: release.title,
                    features: features
                )
            )

            features.removeAll()
            currentRelease = nil
        } else if let release = currentRelease {
            print("Skipping release finalization for \(release.version) due to no features")
        }
    }

    static func parseEscapeSequences(_ input: String) -> String {
        var result = input

        let escapePatterns: [(String, String)] = [
            ("\\\\", "\u{FFFE}"), // Replacement for backslash
            ("\\n", "\n"),
            ("\\r", "\r"),
            ("\\t", "\t"),
            ("\\'", "'"),
            ("\\\"", "\""),
            ("\u{FFFE}", "\\") // Replace backslash representation
        ]

        for (pattern, replacement) in escapePatterns {
            result = result.replacingOccurrences(of: pattern, with: replacement)
        }

        return result
    }

    static func readMarkdownFile(bundle: Bundle, fileName: String) -> String? {
        guard let url = bundle.url(forResource: fileName, withExtension: "md") else { return nil }
        guard let contents = try? String(contentsOf: url) else { return nil }

        return contents
    }
}
