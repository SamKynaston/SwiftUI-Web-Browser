import SwiftUI

struct ContentView: View {
    @State private var browserManager = BrowserManager()
    @State private var selectedTabId: UUID?

    var body: some View {
        NavigationSplitView {
            SideBarView(selectedTabId: $selectedTabId, browserManager: browserManager)
        } detail: {
            if let selectedId = selectedTabId {
                if let activeTab = browserManager.getTab(UUID: selectedId) {
                    WebView(url: activeTab.url) {
                        url, title in browserManager.visitUrl(
                            url,
                            in: selectedId
                        )
                    }
                    .id(activeTab.id)
                    .toolbar {
                        ToolBarView(browserManager: browserManager)
                    }
                }
            }
        }
        .onAppear {
            if selectedTabId == nil {
                selectedTabId = browserManager.tabs.first?.id
            }
        }
    }
}

#Preview {
    ContentView()
}
