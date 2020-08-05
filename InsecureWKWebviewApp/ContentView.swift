//
//  ContentView.swift
//  InsecureWKWebviewApp
//
//  Created by soo cheng koh on 05/08/2020.
//  Copyright © 2020 soo cheng koh. All rights reserved.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
//        Text("Hello, World!")
        WebView(request: URLRequest(url: URL(string: "https://fmytrial3.fundsupermart.com.my/m/")!))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
