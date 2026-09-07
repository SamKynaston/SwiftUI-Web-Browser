//
//  Tabs.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import SwiftUI

@Observable
class BrowserTabsCollection {
    var tabs: [BrowserTab] =  [
        BrowserTab(title: "Google", url: URL(string: "https://www.google.com")!),
        BrowserTab(title: "Amazon", url: URL(string: "https://www.amazon.com")!)
    ]
    
    func createTab(title: String, urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let newTab = BrowserTab(title: title, url: url)
        tabs.append(newTab)
    }
    
    func destroyTab(at offsets: IndexSet) {
        tabs.remove(atOffsets: offsets)
    }
    
    func getTab(UUID: UUID) -> BrowserTab? {
        let tab = tabs.first(where: { $0.id == UUID })
        return tab!
    }
}
