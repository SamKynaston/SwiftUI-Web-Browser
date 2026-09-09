//
//  WebViewController.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI
import WebKit

#if os(macOS)
typealias ViewRepresentable = NSViewRepresentable
#elseif os(iOS)
typealias ViewRepresentable = UIViewRepresentable
#endif

struct WebRenderer: ViewRepresentable {
    let url: URL
    let manager: TabManager
    var tabId: UUID

    func makeCoordinator() -> Coordinator {
        Coordinator(manager: manager, tabId: tabId)
    }
    
    #if os(macOS)

    func makeNSView(context: Context) -> WKWebView {
        makeWebView(context: context)
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        updateWebView(webView)
    }

    #elseif os(iOS)

    func makeUIView(context: Context) -> WKWebView {
        makeWebView(context: context)
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        updateWebView(webView)
    }

    #endif
    
    private func makeWebView(context: Context) -> WKWebView {
        if let existingWebView = manager.getTab(id: tabId)?.webView {
            return existingWebView
        }
        
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        #if os(iOS)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        #elseif os(macOS)
        webView.setValue(false, forKey: "drawsBackground")
        #endif
        
        if let tab = manager.getTab(id: tabId) {
            webView.load(URLRequest(url: tab.url))
        }
        
        context.coordinator.observeProgress(of: webView)
        manager.setTabWebview(webView, for: tabId)
        
        return webView
    }

    private func updateWebView(_ webView: WKWebView) {

    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        private var progressObservation: NSKeyValueObservation?
        
        weak var manager: TabManager?
        let tabId: UUID

        init(manager: TabManager, tabId: UUID) {
            self.manager = manager
            self.tabId = tabId
        }
        
        func observeProgress(of webView: WKWebView) {
            progressObservation = webView.observe(
                \.estimatedProgress,
                options: [.initial, .new]
            ) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    self?.manager?.loadingProgress = webView.estimatedProgress
                }
            }
        }
        
        func webView(
            _ webView: WKWebView,
            didStartProvisionalNavigation navigation: WKNavigation?
        ) {
            manager?.isLoading = true
            manager?.loadingProgress = 0
            updateState(webView)
        }
        
        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation?
        ) {
            manager?.isLoading = false
            manager?.loadingProgress = 1
            updateState(webView)
            updateBackgroundColor(webView)
        }
        
        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation?,
            withError error: Error
        ) {
            manager?.isLoading = false
            updateState(webView)
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation?,
            withError error: Error
        ) {
            manager?.isLoading = false
            updateState(webView)
        }
        
        private func updateBackgroundColor(_ webView: WKWebView) {
            // TODO
        }

        private func updateState(_ webView: WKWebView) {
            guard let manager = manager else { return }
                        
            manager.setTabUrl(webView.url ?? manager.getTab(id: tabId)!.url, for: tabId)
            manager.setTabTitle(webView.title ?? "New Tab", for: tabId)
            
            if manager.activeTabId == tabId {
                manager.canGoBack = webView.canGoBack
                manager.canGoForward = webView.canGoForward
            }
        }
    }
}
