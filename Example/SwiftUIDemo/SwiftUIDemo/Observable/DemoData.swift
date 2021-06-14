//
//  DemoData.swift
//  SwiftUIDemo
//
//  Created by 이동근 on 2021/06/14.
//

import Foundation
import Combine

class DemoData: ObservableObject {
    @Published var currentUser: String = ""
    @Published var userCount: Int = 0
    
    init() {
        updateData()
    }
    
    func updateData() {
        
    }
}
