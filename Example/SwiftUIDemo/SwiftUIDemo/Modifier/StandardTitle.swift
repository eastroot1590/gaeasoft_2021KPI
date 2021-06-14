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
            .shadow(color: Color.black, radius: 5, x: 0, y: 5)
    }
}
