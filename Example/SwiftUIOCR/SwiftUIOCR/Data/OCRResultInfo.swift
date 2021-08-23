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
    }
    
    let word: String
    let box: Box
}
