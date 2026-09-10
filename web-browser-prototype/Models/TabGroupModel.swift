//
//  TabGroupModel.swift
//  web-browser-prototype
//
//  Created by Sam on 08/09/2026.
//

import SwiftUI
import SwiftData

@Model
final class TabGroupModel: Identifiable {
    var id = UUID()
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var tabs: [TabModel]
    
    init(name: String, tabs: [TabModel] = []) {
        self.name = name
        self.tabs = tabs
    }
}
