//
//  TabSheetView.swift
//  web-browser-prototype
//
//  Created by Sam on 10/09/2026.
//

#if os(iOS)
import SwiftUI

struct TabSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var tabManager: TabManager
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tabManager.tabGroups) { group in
                    SideBarTabGroup(tabManager: tabManager, group: group)
                    
                    if tabManager.activeGroup?.id == group.id {
                        ForEach(group.tabs) { tab in
                            SideBarTab(tabManager: tabManager, group: group, tab: tab)
                                .listRowInsets( EdgeInsets( top: 0, leading: 8, bottom: 0, trailing: 8 ) )
                        }
                    }
                }
            }
            .navigationTitle("Tabs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        tabManager.createTabGroup(name: "Default")
                    } label : {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .confirm) {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
#endif
