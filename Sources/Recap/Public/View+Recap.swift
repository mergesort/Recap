import SwiftUI

// MARK: View Modifiers

public extension View {
    /// Configures what index should be first shown when displaying the `RecapScreen`.
    func recapScreenStartIndex(_ startIndex: RecapScreenStartIndex) -> some View {
        self.environment(\.recapScreenStartIndex, startIndex)
    }

    /// Configures a foreground `ShapeStyle` to display the `RecapScreen` title text.
    func recapScreenTitleStyle(_ style: some ShapeStyle) -> some View {
        self.environment(\.recapScreenTitleStyle, AnyShapeStyle(style))
    }

    /// Configures a `backgroundStyle` for the `RecapScreen` dismiss button, defaulting to white for the `foregroundStyle`.
    func recapScreenDismissButtonStyle(_ style: some ShapeStyle) -> some View {
        self.environment(
            \.recapScreenDismissButtonStyle, RecapScreenDismissButtonStyle(
                backgroundStyle: AnyShapeStyle(style),
                foregroundStyle: AnyShapeStyle(Color.white)
            )
        )
    }

    /// Configures a `backgroundStyle` and `foregroundStyle` for the `RecapScreen` dismiss button.
    func recapScreenDismissButtonStyle(_ backgroundStyle: some ShapeStyle, _ foregroundStyle: some ShapeStyle) -> some View {
        self.environment(
            \.recapScreenDismissButtonStyle, RecapScreenDismissButtonStyle(
                backgroundStyle: AnyShapeStyle(backgroundStyle),
                foregroundStyle: AnyShapeStyle(foregroundStyle)
            )
        )
    }

    /// Configures an `IconFillMode` for the icons displayed on the `RecapScreen`.
    func recapScreenIconFillMode(_ style: IconFillMode) -> some View {
        self.environment(\.recapScreenIconFillMode, style)
    }

    /// Configures the `selected` and `deselected` state page indicator colors displayed on the `RecapScreen`.
    func recapScreenPageIndicatorColors(selected: Color, deselected: Color) -> some View {
        self.environment(\.recapScreenSelectedPageIndicatorColor, selected)
            .environment(\.recapScreenDeselectedPageIndicatorColor, deselected)
    }

    /// Configures a background `ShapeStyle` for the `RecapScreen`.
    func recapScreenBackground(_ style: AnyShapeStyle?) -> some View {
        self.environment(\.backgroundStyle, style)
    }

    /// Configures a background `Color` for the `RecapScreen`.
    func recapScreenBackground(_ color: Color) -> some View {
        self.environment(\.backgroundStyle, AnyShapeStyle(color))
    }

    /// Configures additional insets to be applied as padding to the content of the `RecapScreen`.
    func recapScreenPadding(_ insets: EdgeInsets) -> some View {
        self.environment(\.recapScreenPadding, insets)
    }

    /// Configures the spacing to be applied as in between the `RecapScreen` title and a release's featured items.
    func recapScreenHeaderSpacing(_ spacing: CGFloat) -> some View {
        self.environment(\.recapScreenHeaderSpacing, spacing)
    }

    /// Configures the spacing to be applied as in between featured items displayed on the `RecapScreen`.
    func recapScreenItemSpacing(_ spacing: CGFloat) -> some View {
        self.environment(\.recapScreenItemSpacing, spacing)
    }

    /// Configures a customizable action for the `RecapScreen` dismiss button, useful when your screen is presented through non-standard means.
    func recapScreenDismissAction(_ dismissAction: (@Sendable () -> Void)?) -> some View {
        if let dismissAction {
            self.environment(\.recapScreenDismissAction, RecapScreenDismissAction(dismissAction: dismissAction))
        } else {
            self.environment(\.recapScreenDismissAction, nil)
        }
    }
}

// MARK: Environment

internal extension EnvironmentValues {
    // MARK: StartIndex

    @Entry var recapScreenStartIndex = RecapScreenStartIndex.leadingView

    var recapScreenStartIndex2: RecapScreenStartIndex {
        get { self[RecapScreenStartIndexKey.self] }
        set { self[RecapScreenStartIndexKey.self] = newValue }
    }

    private struct RecapScreenStartIndexKey: EnvironmentKey {
        static let defaultValue = RecapScreenStartIndex.leadingView
    }

    // MARK: TitleStyle

    var recapScreenTitleStyle: AnyShapeStyle {
        get { self[TitleStyleKey.self] }
        set { self[TitleStyleKey.self] = newValue }
    }

    private struct TitleStyleKey: EnvironmentKey {
        static let defaultValue = AnyShapeStyle(Color.black)
    }

    // MARK: DismissButtonStyle

    var recapScreenDismissButtonStyle: RecapScreenDismissButtonStyle {
        get { self[DismissButtonStyleKey.self] }
        set { self[DismissButtonStyleKey.self] = newValue }
    }

    private struct DismissButtonStyleKey: EnvironmentKey {
        static let defaultValue = RecapScreenDismissButtonStyle(
            backgroundStyle: AnyShapeStyle(Color.blue),
            foregroundStyle: AnyShapeStyle(Color.white)
        )
    }

    // MARK: DismissAction

    var recapScreenDismissAction: RecapScreenDismissAction? {
        get { self[RecapScreenDismissActionKey.self] }
        set { self[RecapScreenDismissActionKey.self] = newValue }
    }

    private struct RecapScreenDismissActionKey: EnvironmentKey {
        static let defaultValue: RecapScreenDismissAction? = nil
    }

    // MARK: SelectedPageIndicatorColor

    var recapScreenSelectedPageIndicatorColor: Color {
        get { self[SelectedPageIndicatorColorKey.self] }
        set { self[SelectedPageIndicatorColorKey.self] = newValue }
    }

    private struct SelectedPageIndicatorColorKey: EnvironmentKey {
        static let defaultValue = Color.black
    }

    // MARK: DeselectedPageIndicatorColor

    var recapScreenDeselectedPageIndicatorColor: Color {
        get { self[DeselectedPageIndicatorColorKey.self] }
        set { self[DeselectedPageIndicatorColorKey.self] = newValue }
    }

    private struct DeselectedPageIndicatorColorKey: EnvironmentKey {
        static let defaultValue = Color.gray
    }

    // MARK: IconFillMode

    var recapScreenIconFillMode: IconFillMode {
        get { self[IconFillModeKey.self] }
        set { self[IconFillModeKey.self] = newValue }
    }

    private struct IconFillModeKey: EnvironmentKey {
        static let defaultValue = IconFillMode.solid
    }

    // MARK: PaddingKey

    var recapScreenPadding: EdgeInsets {
        get { self[PaddingKey.self] }
        set { self[PaddingKey.self] = newValue }
    }

    private struct PaddingKey: EnvironmentKey {
        static let defaultValue = EdgeInsets(top: 48.0, leading: 32.0, bottom: 24.0, trailing: 32.0)
    }

    // MARK: ItemSpacing

    var recapScreenItemSpacing: CGFloat {
        get { self[ItemSpacingKey.self] }
        set { self[ItemSpacingKey.self] = newValue }
    }

    private struct ItemSpacingKey: EnvironmentKey {
        static let defaultValue = 32.0
    }

    // MARK: HeaderSpacing

    var recapScreenHeaderSpacing: CGFloat {
        get { self[HeaderSpacingKey.self] }
        set { self[HeaderSpacingKey.self] = newValue }
    }

    private struct HeaderSpacingKey: EnvironmentKey {
        static let defaultValue = 32.0
    }
}
