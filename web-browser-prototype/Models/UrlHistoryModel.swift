//
//  UrlHistoryModel.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import WebKit

struct HistoryItem: Hashable {
    let url: URL
    var title: String?
    var visitedAt: Date = .now
}
