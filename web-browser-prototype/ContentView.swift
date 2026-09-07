import SwiftUI

struct ContentView: View {
    @State var browserManager = BrowserManager()

    var body: some View {
        NavigationSplitView {
            SideBarView(browserManager: browserManager)
        } detail: {
            if let selectedId = browserManager.activeTabId {
                if let activeTab = browserManager.getTab(UUID: selectedId) {
                    WebView(
                        url: activeTab.url,
                        manager: activeTab.browserWebManager
                    )
                    .id(activeTab.id)
                    .toolbar {
                        ToolBarView(browserManager: browserManager)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
