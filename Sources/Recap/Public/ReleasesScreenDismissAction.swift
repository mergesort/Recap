/// A customizable action for the `RecapScreen` dismiss button, useful when your screen is presented through non-standard means.
public struct RecapScreenDismissAction {
    /// The closure that defines the dismiss action.
    public let dismissAction: (() -> Void)

    /// Initializes a new `RecapScreenDismissAction` with a custom dismiss action.
    ///
    /// - Parameter dismissAction: A closure that will be executed when the dismiss action is triggered.
    public init(dismissAction: @escaping (() -> Void)) {
        self.dismissAction = dismissAction
    }

    /// Executes the dismiss action.
    ///
    /// This method allows the struct to be called as a function, providing a convenient way to trigger the dismiss action.
    public func callAsFunction() {
        self.dismissAction()
    }
}
