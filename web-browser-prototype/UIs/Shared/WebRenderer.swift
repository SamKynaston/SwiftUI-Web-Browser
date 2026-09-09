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
    
    func makeCoordinator() -> Coordinator {
        Coordinator(manager: manager)
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
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        #if os(iOS)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        #elseif os(macOS)
        webView.setValue(false, forKey: "drawsBackground")
        #endif
        
        if let url = manager.activeTab?.url {
                webView.load(URLRequest(url: url))
        }
        
        context.coordinator.observeProgress(of: webView)
        
        manager.setActiveTabWebview(webView)
        
        manager.onNavigationChange = { url, title in
            if let url {
                manager.setActiveTabUrl(url)
            }
            manager.setActiveTabTitle(title)
        }
        
        return webView
    }

    private func updateWebView(_ webView: WKWebView) {

    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        private var progressObservation: NSKeyValueObservation?
        
        let manager: TabManager

        init(manager: TabManager) {
            self.manager = manager
        }
        
        func observeProgress(of webView: WKWebView) {
            progressObservation = webView.observe(
                \.estimatedProgress,
                options: [.initial, .new]
            ) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    self?.manager.loadingProgress = webView.estimatedProgress
                }
            }
        }
        
        func webView(
            _ webView: WKWebView,
            didStartProvisionalNavigation navigation: WKNavigation?
        ) {
            manager.isLoading = true
            manager.loadingProgress = 0
            updateState(webView)
        }
        
        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation?
        ) {
            manager.isLoading = false
            manager.loadingProgress = 1
            updateState(webView)
            updateBackgroundColor(webView)
        }
        
        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation?,
            withError error: Error
        ) {
            manager.isLoading = false
            updateState(webView)
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation?,
            withError error: Error
        ) {
            manager.isLoading = false
            updateState(webView)
        }
        
        private func updateBackgroundColor(_ webView: WKWebView) {
            // TODO
        }

        private func updateState(_ webView: WKWebView) {
            manager.setActiveTabUrl(webView.url!)
            manager.setActiveTabTitle(webView.title ?? "New Tab")
            manager.canGoBack = webView.canGoBack
            manager.canGoForward = webView.canGoForward

            manager.onNavigationChange?(webView.url, webView.title ?? "New Tab")
        }
    }
}
