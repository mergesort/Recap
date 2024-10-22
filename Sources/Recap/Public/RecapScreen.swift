import SwiftUI

/// A View to display your app's releases.
///
/// This screen presents a horizontally paged view of releases, allowing users to swipe through
/// different versions of the app and view their respective features and changes.
///
/// The `RecapScreen` uses environment values to customize its appearance,
/// including background style, color scheme, page indicator colors, and dismiss button style.
///
/// Usage:
/// ```swift
/// let releases = [
///     Release(version: AppVersion(version: "1.0.0"), title: "Initial Release", features: [...]),
///     Release(version: AppVersion(version: "1.1.0"), title: "Feature Update", features: [...])
/// ]
///
/// RecapScreen(releases: releases)
/// ```
///
/// - Note: The releases are displayed in reverse chronological order, with the most recent release shown first.
public struct RecapScreen<LeadingView: View, TrailingView: View>: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.backgroundStyle) private var backgroundStyle
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.recapScreenStartIndex) private var startIndex
    @Environment(\.recapScreenSelectedPageIndicatorColor) private var selectedPageIndicatorColor
    @Environment(\.recapScreenDeselectedPageIndicatorColor) private var deselectedPageIndicatorColor
    @Environment(\.recapScreenDismissButtonStyle) private var dismissButtonStyle
    @Environment(\.recapScreenDismissAction) private var dismissAction

    @State private var originalSelectedPageIndicatorColor: UIColor?
    @State private var originalDeselectedPageIndicatorColor: UIColor?
    @State private var selectedIndex = 0

    private let releases: [Release]
    private let leadingView: LeadingView
    private let trailingView: TrailingView

    public init(releases: [Release], @ViewBuilder leadingView: () -> LeadingView, @ViewBuilder trailingView: () -> TrailingView) {
        self.releases = releases
        self.leadingView = leadingView()
        self.trailingView = trailingView()
    }

    public var body: some View {
        VStack(spacing: 0.0) {
            TabView(selection: $selectedIndex) {
                self.leadingView
                    .tag(self.tabIndex(from: .leadingView))

                ForEach(self.displayedReleases) { release in
                    ReleaseView(release: release)
                        .padding(.bottom, 32.0)
                        .tag((self.tabIndex(from: .release(
                            self.displayedReleases.firstIndex(of: release) ?? 0)
                        )))
                }

                self.trailingView
                    .tag(self.tabIndex(from: .trailingView))
            }
            .tabViewStyle(.page(indexDisplayMode: self.releases.count > 1 ? .always : .never))
            .background(self.derivedBackgroundStyle)

            Button(action: {
                dismissAction?() ?? dismiss()
            }, label: {
                HStack {
                    Spacer(minLength: 0.0)

                    Text("RECAP.SCREEN.DISMISS.BUTTON.TITLE", bundle: .module)
                        .font(.system(.title3, weight: .bold))
                        .padding(8.0)
                        .padding(.vertical, 4.0)
                        .padding(.horizontal, 16.0)
                        .foregroundStyle(dismissButtonStyle.foregroundStyle)

                    Spacer(minLength: 0.0)
                }
                .contentShape(.rect(cornerRadius: 16.0))
            })
            .frame(maxWidth: .infinity)
            .background(self.dismissButtonStyle.backgroundStyle)
            .clipShape(.rect(cornerRadius: 16.0))
            .padding(.horizontal, 40.0)
            .foregroundStyle(.primary)
            .withBottomPaddingIfNoSafeArea()
            .background(self.derivedBackgroundStyle)
            .onAppear(perform: {
                self.selectedIndex = self.tabIndex(from: self.startIndex)
            })
            .onAppear(perform: {
                self.setupAppearanceChanges()
            })
            .onDisappear(perform: {
                self.teardownAppearanceChanges()
            })
        }
    }
}

// MARK: Convenience Initializers

public extension RecapScreen where LeadingView == EmptyView {
    init(releases: [Release], @ViewBuilder trailingView: () -> TrailingView) {
        self.releases = releases
        self.leadingView = EmptyView()
        self.trailingView = trailingView()
    }
}

public extension RecapScreen where TrailingView == EmptyView {
    init(releases: [Release], @ViewBuilder leadingView: () -> LeadingView) {
        self.releases = releases
        self.leadingView = leadingView()
        self.trailingView = EmptyView()
    }
}

public extension RecapScreen where LeadingView == EmptyView, TrailingView == EmptyView {
    init(releases: [Release]) {
        self.releases = releases
        self.leadingView = EmptyView()
        self.trailingView = EmptyView()
    }
}

// MARK: Private

private extension RecapScreen {
    var displayedReleases: [Release] {
        self.releases.reversed()
    }

    var derivedBackgroundStyle: AnyShapeStyle {
        if let backgroundStyle {
            backgroundStyle
        } else {
            AnyShapeStyle(self.colorScheme == .dark ? Color.black : Color.white)
        }
    }

    func setupAppearanceChanges() {
#if canImport(UIKit)
        self.originalSelectedPageIndicatorColor = UIPageControl.appearance().currentPageIndicatorTintColor
        self.originalDeselectedPageIndicatorColor = UIPageControl.appearance().pageIndicatorTintColor

        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(self.selectedPageIndicatorColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(self.deselectedPageIndicatorColor)
#endif
    }

    func teardownAppearanceChanges() {
#if canImport(UIKit)
        UIPageControl.appearance().currentPageIndicatorTintColor = self.originalSelectedPageIndicatorColor
        UIPageControl.appearance().pageIndicatorTintColor = self.originalDeselectedPageIndicatorColor
#endif
    }


    func tabIndex(from startIndex: RecapScreenStartIndex) -> Int {
        switch startIndex {
        case .leadingView: 0
        case .trailingView: self.releases.count + 1
        case .release(let index): index + 1
        }
    }
}

// MARK: Safe Area Insets

private extension View {
    var hasSafeAreaForBottomPadding: Bool {
#if os(macOS)
        return false
#else
        if UIDevice.current.userInterfaceIdiom == .pad {
            // On iPad, we don't display fullscreen so the home bar isn't relevant.
            return false
        } else {
            return (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0) > 0.0
        }
#endif
    }

    func withBottomPaddingIfNoSafeArea() -> some View {
        guard !hasSafeAreaForBottomPadding else { return self }
        return self.padding(.bottom, 24.0)
    }
}
