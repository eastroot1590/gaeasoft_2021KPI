//
//  ResultView.swift
//  SwiftUIOCR
//
//  Created by 이동근 on 2021/08/23.
//

import SwiftUI

struct ResultView: View {
    var resultImage: UIImage
    var resultInfos: [OCRResultInfo]?
    
//    @State private var resultString: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            let scale = 500 / resultImage.size.height
            
            VStack {
                ZStack {
                    Image(uiImage: resultImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: 500)
                    
                    Path { path in
                        guard let  results = resultInfos else {
                            return
                        }
                        
                        for result in results {
                            path.move(to: CGPoint(x: result.box.lt.x * scale, y: result.box.lt.y * scale))
                            
                            path.addLine(to: CGPoint(x: result.box.rt.x * scale, y: result.box.rt.y * scale))
                            path.addLine(to: CGPoint(x: result.box.rb.x * scale, y: result.box.rb.y * scale))
                            path.addLine(to: CGPoint(x: result.box.lb.x * scale, y: result.box.lb.y * scale))
                            path.addLine(to: CGPoint(x: result.box.lt.x * scale, y: result.box.lt.y * scale))
                        }
                    }
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: resultImage.size.width * scale, height: 500)
                }
                
                let resultString: String = {
                    guard let results = resultInfos else {
                        return ""
                    }
                    
                    var resultString = ""
                    for result in results {
                        resultString += "[\(result.word)] "
                    }
                    
                    return resultString
                }()
                
                Text(resultString)
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(resultImage: UIImage(named: "sample2")!, resultInfos: [
            OCRResultInfo(word: "hello", box: OCRResultInfo.Box(lt: CGPoint(x: 10, y: 10),
                                                                rt: CGPoint(x: 110, y: 10),
                                                                rb: CGPoint(x: 110, y: 110),
                                                                lb: CGPoint(x: 10, y: 110)))
        ])
    }
}
