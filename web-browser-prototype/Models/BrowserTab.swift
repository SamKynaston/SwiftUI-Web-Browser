//
//  BrowserTab.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation

struct BrowserTab: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var url: URL
}
