//
//  TabManager.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import SwiftUI
import WebKit

@Observable
class TabManager {
    var tabGroups: [TabGroupModel] = [
        TabGroupModel(name: "Default", tabs: [
            TabModel(url: URL(string: "https://www.google.com")!),
            TabModel(url: URL(string: "https://www.amazon.com")!)
        ]),
        
        TabGroupModel(name: "Default2", tabs: [
            TabModel(url: URL(string: "https://www.google.com")!),
            TabModel(url: URL(string: "https://www.amazon.com")!)
        ])
    ]
    
    var activeTab: TabModel?
    var activeGroup: TabGroupModel?
    
    var browserTabs: [TabModel] {
        tabGroups.flatMap(\.tabs)
    }
}
