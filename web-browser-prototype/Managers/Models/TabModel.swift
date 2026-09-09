//
//  TabModel.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import WebKit

@Observable
final class TabModel: Identifiable {
    let id = UUID()
    var webView: WKWebView? = nil
    var title: String = "New Tab"
    var url: URL
    var onNavigationChange: ((URL?, String) -> Void)?

    init(url: URL) {
        self.url = url
    }
}
