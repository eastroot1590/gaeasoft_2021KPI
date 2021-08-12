//
//  OCRTool.swift
//  SwiftUIOCR
//
//  Created by 이동근 on 2021/07/26.
//

import Foundation

enum OCRTool {
    case Kakao
    case Google
    
    func description() -> String {
        switch self {
        case .Kakao:
            return "Kakao"
            
        case .Google:
            return "Google"
        }
    }
}
