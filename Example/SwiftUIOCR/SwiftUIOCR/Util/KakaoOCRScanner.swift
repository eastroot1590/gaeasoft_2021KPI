//
//  KakaoOCRScanner.swift
//  GaeaOCRScanner
//
//  Created by 이동근 on 2021/07/02.
//

import UIKit

struct KakaoResponse: Decodable {
    struct OCRResult: Decodable {
        let boxes: [[Int]]
        let recognition_words: [String]
    }
    
    let result: [OCRResult]
}

class KakaoOCRScanner: OCRScanner {
    func scan(_ sourceImage: UIImage, completed: @escaping ([OCRResultInfo]?) -> Void) {
        guard let url = URL(string: "https://dapi.kakao.com/v2/vision/text/ocr"),
              let imageBinary = sourceImage.jpegData(compressionQuality: 1),
              let apiKey = Bundle.main.object(forInfoDictionaryKey: "Kakao API Key") as? String else {
            return
        }
        
        print("size: \(imageBinary.count / 1024)kb")

        let boundary: String = "\(UUID().uuidString)"
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")

        // multipart/form-data format
        var body: Data = Data()
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"sample.jpeg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageBinary)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            print(response.debugDescription)
            
            guard let data = data,
                  let result = try? JSONDecoder().decode(KakaoResponse.self, from: data) else {
                completed(nil)
                return
            }
            
            var ocrResults: [OCRResultInfo] = []
            
            for block in result.result {
                var blockWord: String = ""
                
                for word in block.recognition_words {
                    blockWord.append("\(word) ")
                }
                
                ocrResults.append(OCRResultInfo(word: blockWord,
                                                box: OCRResultInfo.Box(lt: CGPoint(x: block.boxes[0][0], y: block.boxes[0][1]),
                                                                       rt: CGPoint(x: block.boxes[1][0], y: block.boxes[1][1]),
                                                                       rb: CGPoint(x: block.boxes[2][0], y: block.boxes[2][1]),
                                                                       lb: CGPoint(x: block.boxes[3][0], y: block.boxes[3][1]))))
            }
            
            DispatchQueue.main.async {
                completed(ocrResults)
            }
        }).resume()
    }
}
