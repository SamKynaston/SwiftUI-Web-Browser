//
//  TabGroupModel.swift
//  web-browser-prototype
//
//  Created by Sam on 08/09/2026.
//

import SwiftUI

struct TabGroupModel: Identifiable {
    let id: UUID
    let tabs: [TabModel]
    
    public init(tabs: [TabModel]) {
        self.id = UUID()
        self.tabs = tabs
    }
}
