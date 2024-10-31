import SwiftUI

struct ReleaseView: View {
    @Environment(\.recapScreenPadding) private var padding: EdgeInsets
    @Environment(\.recapScreenHeaderSpacing) private var titleSpacing: CGFloat
    @Environment(\.recapScreenTitleStyle) private var titleStyle: AnyShapeStyle
    @Environment(\.recapScreenItemSpacing) private var itemSpacing: CGFloat

    let release: Release

    var body: some View {
        VStack(alignment: .center, spacing: self.titleSpacing) {
            Text(.init(release.title), bundle: .module)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(self.titleStyle)
                .multilineTextAlignment(.center)
                .padding(.leading, self.padding.leading)
                .padding(.trailing, self.padding.trailing)

            ScrollView {
                VStack(alignment: .leading, spacing: self.itemSpacing) {
                    ForEach(release.features) { feature in
                        FeatureRow(feature: feature)
                    }
                }
                .padding(.leading, self.padding.leading)
                .padding(.trailing, self.padding.trailing)
            }
            .withSizedBasedBounceBehaviorIfAvailable()
        }
        .padding(.top, self.padding.top)
        .padding(.bottom, self.padding.bottom)
    }
}

// MARK: ScrollView

fileprivate extension ScrollView {
    func withSizedBasedBounceBehaviorIfAvailable() -> some View {
        if #available(iOS 16.4, macCatalyst 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
            return self.scrollBounceBehavior(.basedOnSize)
        }

        return self
    }
}
