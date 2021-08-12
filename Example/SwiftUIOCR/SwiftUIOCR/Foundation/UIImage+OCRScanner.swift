//
//  UIImage+OCRScanner.swift
//  SwiftUIOCR
//
//  Created by 이동근 on 2021/07/26.
//

import UIKit

extension UIImage {
    func scaledImage(_ maxDimension: CGFloat) -> UIImage? {
        guard size.width > maxDimension || size.height > maxDimension else {
            return self
        }
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            scaledSize.height = size.height / size.width * scaledSize.width
        } else {
            scaledSize.width = size.width / size.height * scaledSize.height
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}
