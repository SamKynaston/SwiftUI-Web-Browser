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
    let manager: TabManager
    let tab: TabModel

    func makeCoordinator() -> Coordinator {
        Coordinator(manager: manager, tab: tab)
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
        let webView = tab.webView
        
        webView.navigationDelegate = context.coordinator
        
        #if os(iOS)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        #elseif os(macOS)
        webView.setValue(false, forKey: "drawsBackground")
        #endif
        
        if webView.url == nil {
            webView.load(URLRequest(url: tab.url))
        }
        
        context.coordinator.observeProgress(of: webView)
        
        return webView
    }

    private func updateWebView(_ webView: WKWebView) {

    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        private var progressObservation: NSKeyValueObservation?
        
        weak var manager: TabManager?
        let tab: TabModel

        init(manager: TabManager, tab: TabModel) {
            self.manager = manager
            self.tab = tab
        }
        
        func observeProgress(of webView: WKWebView) {
            progressObservation = webView.observe(
                \.estimatedProgress,
                options: [.initial, .new]
            ) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    self?.tab.loadingProgress = webView.estimatedProgress
                }
            }
        }
        
        func webView(
            _ webView: WKWebView,
            didStartProvisionalNavigation navigation: WKNavigation?
        ) {
            tab.isLoading = true
            tab.loadingProgress = 0
            updateState(webView)
        }
        
        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation?
        ) {
            tab.isLoading = false
            tab.loadingProgress = 1
            updateState(webView)
            updateBackgroundColor(webView)
        }
        
        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation?,
            withError error: Error
        ) {
            tab.isLoading = false
            updateState(webView)
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation?,
            withError error: Error
        ) {
            tab.isLoading = false
            updateState(webView)
        }
        
        private func updateBackgroundColor(_ webView: WKWebView) {
            // TODO
        }

        private func updateState(_ webView: WKWebView) {
            guard let manager = manager else { return }

            manager.setTabUrl(webView.url ?? tab.url, for: tab)
            manager.setTabTitle(webView.title ?? "New Tab", for: tab)

            tab.canGoBack = webView.canGoBack
            tab.canGoForward = webView.canGoForward
        }
    }
}
