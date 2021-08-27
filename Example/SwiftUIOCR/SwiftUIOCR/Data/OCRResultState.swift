//
//  OCRResultState.swift
//  SwiftUIOCR
//
//  Created by 이동근 on 2021/08/27.
//

import SwiftUI

class OCRResultState: ObservableObject {
    @Published var result: [OCRResultInfo]?
}
