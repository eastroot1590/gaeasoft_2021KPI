//
//  MLVisionOCRScanner.swift
//  GaeaOCRScanner
//
//  Created by 이동근 on 2021/07/02.
//

import UIKit
import FirebaseMLVision

class MLVisionOCRScanner: OCRScanner {
    func scan(_ sourceImage: UIImage, completed: @escaping ([OCRResultInfo]?) -> Void) {
        
        let vision = Vision.vision()
        let options = VisionCloudTextRecognizerOptions()
        options.languageHints = ["en", "ko"]
        
        let textRecognizer = vision.cloudTextRecognizer(options: options)
        textRecognizer.process(VisionImage(image: sourceImage)) { result, error in
            if let error = error {
                debugPrint(error)
            }
            
            guard let result = result else {
                completed(nil)
                return
            }
            
//            var resultString: [String] = []
            var ocrResult: [OCRResultInfo] = []
            
            for block in result.blocks {
                
                let word = block.text
                let box = OCRResultInfo.Box(rect: block.frame)
//                resultString.append(block.text)
                ocrResult.append(OCRResultInfo(word: word, box: box))
            }
            
//            completed(resultString)
            completed(ocrResult)
        }
    }
    
    func scan(_ sourceImage: UIImage, completed: @escaping ([String]?) -> Void) {
        let vision = Vision.vision()
        let options = VisionCloudTextRecognizerOptions()
        options.languageHints = ["en", "ko"]
        
        let textRecognizer = vision.cloudTextRecognizer(options: options)
        textRecognizer.process(VisionImage(image: sourceImage)) { result, error in
            if let error = error {
                debugPrint(error)
            }
            
            guard let result = result else {
                completed(nil)
                return
            }
            
            var resultString: [String] = []
            for block in result.blocks {
                resultString.append(block.text)
            }
            
            completed(resultString)
        }
    }
}
