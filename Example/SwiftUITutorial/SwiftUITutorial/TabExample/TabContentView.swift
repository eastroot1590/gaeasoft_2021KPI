//
//  TabContentView.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/07/25.
//

import SwiftUI

struct TabContentView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            Text("FirstContentView")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Screen One")
                }.tag(1)
            Text("SecondContentView")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Screen Two")
                }.tag(2)
            Text("ThirdContentView")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Screen Three")
                }.tag(3)
        }
        .font(.largeTitle)
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabContentView()
    }
}
