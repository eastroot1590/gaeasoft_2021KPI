//
//  BasicLayout.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/06/15.
//

import SwiftUI

struct BasicLayout: View {
    @State private var rotation: Double = 0
    @State private var userInput: String = ""
    @State private var colorIndex: Int = 0
    
    private var colors: [Color] = [.red, .blue, .green, .black]
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(userInput)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(colors[colorIndex])
                .rotationEffect(Angle(degrees: rotation))
                .animation(.easeInOut(duration: 0.5))
            
            Spacer()
            Divider()
            
            Slider(value: $rotation, in: 0...360, step: 0.1)
                .padding()
            
            TextField("입력하세요", text: $userInput)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
            
            Picker(selection: $colorIndex, label: Text("Color"), content: {
                ForEach (0 ..< colors.count) {
                    Text(self.colors[$0].description)
                        .foregroundColor(self.colors[$0])
                }
            })
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BasicLayout()
    }
}
