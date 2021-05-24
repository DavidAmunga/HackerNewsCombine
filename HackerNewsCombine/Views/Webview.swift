//
//  Webview.swift
//  HackerNewsCombine
//
//  Created by David Amunga on 24/05/2021.
//

import Foundation
import SwiftUI
import WebKit

struct Webview:UIViewRepresentable{
    
    var url:String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {fatalError("Invalid Error")}
        
        let request = URLRequest(url:url)
        
        let wkWebview = WKWebView()
        wkWebview.load(request)
        return wkWebview
    }
    
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
