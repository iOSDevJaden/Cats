//
//  CatWikiView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/19.
//

import SwiftUI
import WebKit

struct CatWikiView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> some WKWebView {
        let webView = WKWebView()
        webView.uiDelegate = context.coordinator
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(
        _ uiView: UIViewType,
        context: Context
    ) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKUIDelegate {
        
    }
}

struct CatWikiView_Previews: PreviewProvider {
    static var previews: some View {
        CatWikiView(
            url: Breed.staticBreed.wikipediaUrl ?? ""
        )
    }
}
