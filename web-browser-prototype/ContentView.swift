import SwiftUI

#if os(macOS)
struct MainDesktopView: View {
    @Bindable var browserManager: BrowserTabManager

    var body: some View {
        NavigationSplitView {
            SideBarView(browserManager: browserManager)
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
            TabRenderer(browserManager: browserManager)
                .toolbar {
                    ToolBarView(browserManager: browserManager)
                }
        }
    }
}
#endif

#if os(iOS)
struct MainMobileView: View {
    @Bindable var browserManager: BrowserTabManager

    var body: some View {
        ZStack(alignment: .bottom) {
            TabRenderer(browserManager: browserManager)
                .ignoresSafeArea()
        }
        .safeAreaInset(edge: .bottom) {
            AddressBar(browserManager: browserManager)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .glassEffect(.regular.interactive(), in: .capsule)
                .padding(.horizontal)
                .keyboardType(.URL)
        }
    }
}
#endif

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
