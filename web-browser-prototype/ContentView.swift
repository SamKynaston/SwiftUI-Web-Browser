import SwiftUI

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
        }
    }
}

struct MainMobileView: View {
    @Bindable var tabManager: TabManager
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabRenderer(tabManager: tabManager)
                .ignoresSafeArea(.container, edges: .bottom)
        }
        .toolbar {
            ToolBarView(tabManager: tabManager)
        }
    }
}
#endif

struct ContentView: View {
    @State var tabManager = TabManager()
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        #if os(macOS)
            MainDesktopView(tabManager: tabManager)
        #elseif os(iOS)
        if horizontalSizeClass == .regular {
            MainTabletView(tabManager: tabManager)
        } else {
            MainMobileView(tabManager: tabManager)
        }
        #endif
    }
}

#Preview {
    ContentView()
}
