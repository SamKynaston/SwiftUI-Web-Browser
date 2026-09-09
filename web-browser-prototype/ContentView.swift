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
                            browserManager.createTabGroup(name: "Default")
                        } label: {
                            Image(systemName: "rectangle.badge.plus")
                        }
                    }
                }
        } detail: {
            TabRenderer(tabManager: tabManager)
                .toolbar {
                    DesktopToolBarView(tabManager: tabManager)
                }
        }
    }
}
#endif

#if os(iOS)
struct MainiPadView: View {
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
                    DesktopToolBarView(tabManager: tabManager)
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
            
            /*AddressBar(browserManager: browserManager)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .glassEffect(.regular.interactive(), in: .capsule)
                .padding(.horizontal)
                .keyboardType(.webSearch)
                .textInputAutocapitalization(.never)*/
        }
        .toolbar {
            MobileToolbarView(tabManager: tabManager)
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
            MainiPadView(tabManager: tabManager)
        } else {
            MainMobileView(tabManager: tabManager)
        }
        #endif
    }
}

#Preview {
    ContentView()
}
