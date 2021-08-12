//
//  OCRScanner.swift
//  GaeaOCRScanner
//
//  Created by 이동근 on 2021/07/02.
//

import UIKit

protocol OCRScanner {
    func scan(_ sourceImage: UIImage, completed: @escaping (String) -> Void)
}
