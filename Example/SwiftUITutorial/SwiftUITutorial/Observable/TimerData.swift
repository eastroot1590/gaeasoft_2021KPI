//
//  TimerData.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/06/15.
//

import Foundation
import Combine

class TimerData: ObservableObject {
    @Published var timerCount: Int = 0
    var timer: Timer?
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerDidFire() {
        timerCount += 1
    }
    
    func reset() {
        timerCount = 0
    }
}
