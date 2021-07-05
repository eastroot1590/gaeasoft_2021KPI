//
//  CarStore.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/07/05.
//

import SwiftUI
import Combine

class CarStore: ObservableObject {
    @Published var cars: [Car]
    
    init(cars: [Car] = []) {
        self.cars = cars
    }
}
