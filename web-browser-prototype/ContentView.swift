import SwiftUI

struct MainDesktopView: View {
    @Bindable var browserManager: BrowserTabManager

    var body: some View {
        NavigationSplitView {
            SideBarView(browserManager: browserManager)
        } detail: {
            TabRenderer(browserManager: browserManager)
            
            .toolbar {
                ToolBarView(
                    browserManager: browserManager
                )
            }
        }
    }
}

struct MainMobileView: View {
    @Bindable var browserManager: BrowserTabManager

    var body: some View {
        ZStack(alignment: .bottom) {
            TabRenderer(browserManager: browserManager)
                .ignoresSafeArea()
        }
        .safeAreaInset(edge: .bottom) {
            AddressBar(browserManager: browserManager)
                .padding(.horizontal)
                .padding(.bottom, 4)
        }
    }
}

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
