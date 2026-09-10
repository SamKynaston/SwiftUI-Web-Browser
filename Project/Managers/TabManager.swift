//
//  TabManager.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import SwiftUI
import WebKit
import SwiftData

@Observable
class TabManager {
    let modelContext: ModelContext
    
    var tabGroups: [TabGroupModel] = []
    var activeTab: TabModel?
    var activeGroup: TabGroupModel?
    
    var browserTabs: [TabModel] {
        tabGroups.flatMap(\.tabs)
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadPersistedTabs()
    }
}
