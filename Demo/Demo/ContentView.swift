import Recap
import SwiftUI

struct ContentView: View {
    @State private var isPresentingRecapScreen = false

    var body: some View {
        VStack {
            self.showReleasesButton
        }
        .task({
            try? await Task.sleep(for: .seconds(0.5))
            self.isPresentingRecapScreen = true
        })
        .sheet(isPresented: $isPresentingRecapScreen, content: {
            self.recapScreen
        })
    }

    var showReleasesButton: some View {
        Button(action: {
            self.isPresentingRecapScreen = true
        }, label: {
            Label("Show What's New", systemImage: "sparkles")
        })
    }

    // Optionally you can add a `leadingView` and `trailingView` to your RecapScreen.
    // If you do, you may also wish to specify the start index of your RecapScreen
    // by using the `.recapScreenStartIndex()` modifier, which takes three parameters:
    // .leadingView, .trailingView, and `.release(Int)`, specifying the index of the release you wish to display.
    var recapScreen: some View {
        RecapScreen(releases: .releases)
            .recapScreenDismissButtonStyle(Color.pink, Color.white)
            .recapScreenIconFillMode(.gradient)
            .recapScreenTitleStyle(.foreground)
            .recapScreenPageIndicatorColors(
                selected: Color.pink,
                deselected: Color.gray
            )
    }
}

public extension [Release] {
    static var releases: [Release] {
        ReleasesParser(fileName: "Releases").releases
    }
}

#Preview {
    ContentView()
}
