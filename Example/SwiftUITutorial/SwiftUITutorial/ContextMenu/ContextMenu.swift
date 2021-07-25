//
//  ContextMenu.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/07/25.
//

import SwiftUI

struct ContextMenu: View {
    @State private var foregroundColor: Color = Color.black
    @State private var backgroundColor: Color = Color.white
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .padding()
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .contextMenu(menuItems: {
                Button(action: {
                    self.foregroundColor = .black
                    self.backgroundColor = .white
                }, label: {
                    Text("Normal Color")
                    Image(systemName: "paintbrush")
                })
                
                Button(action: {
                    self.foregroundColor = .white
                    self.backgroundColor = .black
                }, label: {
                    Text("InvertedColor")
                    Image(systemName: "paintbrush.fill")
                })
            })
    }
}

struct ContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenu()
    }
}
