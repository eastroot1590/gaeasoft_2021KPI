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
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: resultImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Path { path in
                guard let  results = resultInfos else {
                    return
                }
                
                let scale = geometry.size.width / resultImage.size.width
                
                for result in results {
                    path.move(to: CGPoint(x: result.box.lt.x * scale, y: result.box.lt.y * scale))
                    
                    path.addLine(to: CGPoint(x: result.box.rt.x * scale, y: result.box.rt.y * scale))
                    path.addLine(to: CGPoint(x: result.box.rb.x * scale, y: result.box.rb.y * scale))
                    path.addLine(to: CGPoint(x: result.box.lb.x * scale, y: result.box.lb.y * scale))
                    path.addLine(to: CGPoint(x: result.box.lt.x * scale, y: result.box.lt.y * scale))
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(resultImage: UIImage(named: "sample")!)
    }
}
