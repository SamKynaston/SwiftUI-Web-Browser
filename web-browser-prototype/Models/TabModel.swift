//
//  TabModel.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation

struct TabModel: Identifiable {
    let id = UUID()
    var title: String
    var url: URL
    let browserWebManager: BrowserWebManager

    init(title: String = "New Tab", url: URL) {
        self.title = title
        self.url = url
        self.browserWebManager = BrowserWebManager()
    }
}
