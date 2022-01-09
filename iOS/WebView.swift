//
//  WebView.swift
//  Koi
//
//  Created by Edgar Mejía on 2/1/22.
//

#if os(iOS)
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}
#endif
