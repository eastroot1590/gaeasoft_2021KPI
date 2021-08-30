//
//  OCRResultInfo.swift
//  SwiftUIOCR
//
//  Created by 이동근 on 2021/08/23.
//

import SwiftUI

struct OCRResultInfo {
    struct Box {
        let lt: CGPoint
        let rt: CGPoint
        let rb: CGPoint
        let lb: CGPoint
        
        init(lt: CGPoint, rt: CGPoint, rb: CGPoint, lb: CGPoint) {
            self.lt = lt
            self.rt = rt
            self.rb = rb
            self.lb = lb
        }
        
        init(rect: CGRect) {
            self.lt = CGPoint(x: rect.minX, y: rect.minY)
            self.rt = CGPoint(x: rect.maxX, y: rect.minY)
            self.rb = CGPoint(x: rect.maxX, y: rect.maxY)
            self.lb = CGPoint(x: rect.minX, y: rect.maxY)
        }
    }
    
    let word: String
    let box: Box
    
}
