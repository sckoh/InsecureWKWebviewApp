//
//  WebView.swift
//  Todos
//
//  Created by Bradley Hilton on 6/5/19.
//  Copyright © 2019 Brad Hilton. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    // Make a coordinator to co-ordinate with WKWebView's default delegate functions
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        // Enable javascript in WKWebView to interact with the web app
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        
        func isInsecureSSLAllowed() -> Bool {
            let appTransportSecurity = Bundle.main.object(forInfoDictionaryKey: "NSAppTransportSecurity") as! NSDictionary?
            let allowArbitraryLoads: Int = (appTransportSecurity?["NSAllowsArbitraryLoads"] ?? 0) as! Int;
            return allowArbitraryLoads == 1
        }
        
        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if (isInsecureSSLAllowed()) {
                let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                completionHandler(.useCredential, cred)
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
        }
    }
    
}

#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://fmytrial3.fundsupermart.com.my/m/")!))
    }
}
#endif
