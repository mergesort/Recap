import SwiftUI

struct FeatureRow: View {
    @Environment(\.recapScreenIconFillMode) private var iconFillMode

    let feature: Feature

    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            ZStack(alignment: .center) {
                Color.clear
                    .frame(width: 48.0, height: 48.0)

                Image(systemName: feature.symbolName)
                    .foregroundStyle(self.iconForegroundStyle)
                    .font(.system(size: 32.0))
            }

            VStack(alignment: .leading, spacing: 4.0) {
                Text(.init(feature.title))
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(.init(feature.description))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private extension FeatureRow {
    var iconForegroundStyle: AnyShapeStyle {
        switch self.iconFillMode {

        case .gradient:
            AnyShapeStyle(self.feature.color.gradient)

        case .solid:
            AnyShapeStyle(self.feature.color)
        }
    }
}
