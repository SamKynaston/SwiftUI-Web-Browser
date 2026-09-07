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
    
    private(set) var urlHistory: [HistoryItem]
    private(set) var currentIndex: Int
    
    var url: URL {
        urlHistory[currentIndex].url
    }
    
    init(title: String = "New Tab", url: URL) {
        self.title = title
        self.urlHistory = [
            HistoryItem(url: url)
        ]
        self.currentIndex = 0
    }
    
    mutating func visit(_ url: URL) {
        urlHistory = Array(urlHistory.prefix(currentIndex + 1))

        urlHistory.append(
            HistoryItem(
                url: url,
                title: title
            )
        )
        currentIndex += 1
    }

    mutating func goBack() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }

    mutating func goForward() {
        guard currentIndex < urlHistory.count - 1 else { return }
        currentIndex += 1
    }

    var canGoBack: Bool {
        currentIndex > 0
    }

    var canGoForward: Bool {
        currentIndex < urlHistory.count - 1
    }
}
