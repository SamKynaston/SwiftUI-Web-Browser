import SwiftUI
import SwiftData

#if os(macOS)
struct MainDesktopView: View {
    @Bindable var tabManager: TabManager

    var body: some View {
        NavigationSplitView {
            SideBarView(tabManager: tabManager)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button {
                            tabManager.createTabGroup(name: "Default")
                        } label: {
                            Image(systemName: "rectangle.badge.plus")
                        }
                    }
                }
                .frame(minWidth: 200, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity, alignment: .center)
        } detail: {
            TabRenderer(tabManager: tabManager)
                .toolbar {
                    ToolBarView(tabManager: tabManager)
                }
        }
    }
}
#endif

#if os(iOS)
struct MainTabletView: View {
    @Bindable var tabManager: TabManager
    
    var body: some View {
        NavigationSplitView {
            SideBarView(tabManager: tabManager)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button {
                            tabManager.createTabGroup(name: "Default")
                        } label: {
                            Image(systemName: "rectangle.badge.plus")
                        }
                    }
                }
        } detail: {
            TabRenderer(tabManager: tabManager)
                .toolbar {
                    ToolBarView(tabManager: tabManager)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

struct MainMobileView: View {
    @Bindable var tabManager: TabManager
    
    var body: some View {
        NavigationStack {
            TabRenderer(tabManager: tabManager)
                .ignoresSafeArea(.container, edges: .bottom)
                .toolbar {
                    ToolBarView(tabManager: tabManager)
                }
        }
    }
}
#endif

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var tabManager: TabManager?
    
    var body: some View {
        Group {
            if let tabManager {
                #if os(macOS)
                    MainDesktopView(tabManager: tabManager)
                        .onAppear {
                            NSWindow.allowsAutomaticWindowTabbing = false
                        }
                #elseif os(iOS)
                if horizontalSizeClass == .regular {
                    MainTabletView(tabManager: tabManager)
                } else {
                    MainMobileView(tabManager: tabManager)
                }
                #endif
            }
        }
        .task {
            if tabManager == nil {
                tabManager = TabManager(modelContext: modelContext)
            }
        }
    }
}

#Preview {
    ContentView()
}
