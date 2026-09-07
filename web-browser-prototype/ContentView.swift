import SwiftUI

struct ContentView: View {
    @State private var tabs: [BrowserTab] = [
        BrowserTab(title: "Google", url: URL(string: "https://www.google.com")!),
        BrowserTab(title: "Amazon", url: URL(string: "https://www.amazon.com")!)
    ]
    @State private var selectedTabId: UUID?

    var body: some View {
        NavigationSplitView {
            SideBarView(selectedTabId: $selectedTabId, tabs: tabs)
            .navigationTitle("Sidebar")
        } detail: {
            if let activeTab = activeTab {
                WebView(url: activeTab.url)
                .id(activeTab.id)
                .toolbar {
                    ToolBarView()
                }
            }
        }
        .onAppear {
            if selectedTabId == nil {
                selectedTabId = tabs.first?.id
            }
        }
    }
    
    private var activeTab: BrowserTab? {
        tabs.first(where: { $0.id == selectedTabId })
    }
    
    private func addNewTab() {
        let newTab = BrowserTab(title: "New Tab", url: URL(string: "https://www.google.com")!)
        tabs.append(newTab)
        selectedTabId = newTab.id
    }
}

#Preview {
    ContentView()
}
