//
//  UserAgreementView.swift
//  Schedulo
//
//  Created by Viktor Zavhorodnii on 07/07/2025.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct UserAgreementView: View {
    var body: some View {
        WebView(url: URL(string: "https://yandex.ru/legal/practicum_offer")!)
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle(Text("Пользовательское соглашение"))
            .toolbarRole(.editor)
            .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    UserAgreementView()
}
