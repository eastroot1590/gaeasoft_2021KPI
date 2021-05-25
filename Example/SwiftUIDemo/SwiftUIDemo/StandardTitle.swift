//
//  StandardTitle.swift
//  SwiftUIDemo
//
//  Created by 이동근 on 2021/05/17.
//

import SwiftUI

struct StandardTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .background(Color.white)
            .border(Color.gray, width: 0.2)
            .shadow(color: Color.black, radius: 5, x: 0, y: 5)
    }
}
