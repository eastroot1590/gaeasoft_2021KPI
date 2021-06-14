//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 이동근 on 2021/05/17.
//

import SwiftUI
import Combine

struct ContentView: View {
    var title: some View {
        VStack {
            Text("Hello world")
            Text("this is SwiftUI tutorial")
        }
    }
    
    @State private var userName = ""
    @State private var wifiEnabled = false
    
    @EnvironmentObject var demoData: DemoData
    
    var body: some View {
        VStack {
            Text("StandardTitle")
                .modifier(StandardTitle())
            
            TextField("이름을 입력하세요", text: $userName)
            
            Text(userName)
            
            Toggle(isOn: $wifiEnabled) {
                Text("와이파이!")
            }
            
            WifiImage(flag: $wifiEnabled)
            
            Text("\(demoData.currentUser)님, \(demoData.userCount)번째 사용자입니다.")
        }
        .padding([.leading, .trailing])
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DemoData())
    }
}
