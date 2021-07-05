//
//  Car.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/07/05.
//

import SwiftUI

struct Car: Codable, Identifiable {
    let id: String
    let name: String
    
    let description: String
    let isHybrid: Bool
    
    let imageName: String
}
