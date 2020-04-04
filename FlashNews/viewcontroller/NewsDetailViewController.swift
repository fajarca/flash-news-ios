//
//  NewsDetailView.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 04/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView(url: "https://learnappmaking.com")
    }
    
    private func setupWebView(url : String) {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.navigationDelegate = self
    }
}

extension NewsDetailViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        startActivityIndicator()
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        stopActivityIndicator()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
        print(error)
        stopActivityIndicator()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function)
        print(error)
        stopActivityIndicator()
    }
    
    private func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    private func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
