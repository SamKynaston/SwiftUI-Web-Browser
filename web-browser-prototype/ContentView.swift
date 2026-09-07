import SwiftUI

struct ContentView: View {
    @State private var browserManager = BrowserTabsCollection()
    @State private var selectedTabId: UUID?

    var body: some View {
        NavigationSplitView {
            SideBarView(selectedTabId: $selectedTabId, tabs: browserManager.tabs)
        } detail: {
            if let selectedId = selectedTabId {
                if let activeTab = browserManager.getTab(UUID: selectedId) {
                    WebView(url: activeTab.url)
                        .id(activeTab.id)
                        .toolbar {
                            ToolBarView()
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
