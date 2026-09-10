import SwiftUI
import SwiftData

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            TabGroupModel.self,
            TabModel.self
        ])
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
