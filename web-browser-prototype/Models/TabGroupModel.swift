//
//  TabGroupModel.swift
//  web-browser-prototype
//
//  Created by Sam on 08/09/2026.
//

import SwiftUI

@Observable
final class TabGroupModel: Identifiable {
    let id = UUID()
    
    var name: String
    var tabs: [TabModel]
    
    init(name: String, tabs: [TabModel]) {
        self.name = name
        self.tabs = tabs
    }
}
