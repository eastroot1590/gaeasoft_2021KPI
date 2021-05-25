//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 이동근 on 2021/05/17.
//

import SwiftUI

struct ContentView: View {
    var title: some View {
        VStack {
            Text("Hello world")
            Text("this is SwiftUI tutorial")
        }
    }
    
    var body: some View {
        Text("StandardTitle")
            .modifier(StandardTitle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
