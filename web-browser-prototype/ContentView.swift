import SwiftUI

struct ContentView: View {
    @State var browserManager = BrowserTabManager()
    
    var body: some View {
        #if os(macOS)
            MainDesktopView(browserManager: browserManager)
        #elseif os(iOS)
            MainMobileView(browserManager: browserManager)
        #endif
    }
}

#Preview {
    ContentView()
}
