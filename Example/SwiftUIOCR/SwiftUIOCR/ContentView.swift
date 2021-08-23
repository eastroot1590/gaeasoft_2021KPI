//
//  ContentView.swift
//  SwiftUIOCR
//
//  Created by 이동근 on 2021/07/26.
//

import SwiftUI

struct ContentView: View {
    let ocrTools: [OCRTool] = [.Kakao, .Google]
    
    @State var showImagePicker = false
    @State var showResult = false
    @State var resultText: Text? = nil
    @State var ocrTool = 0
    
    @State var resultImage: UIImage = UIImage()
    @State var resultInfos: [OCRResultInfo]?
    
    let ocrScanner = KakaoOCRScanner()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Picker(selection: $ocrTool, label: Text("OCR Tools"), content: {
                    ForEach(0 ..< ocrTools.count) { i in
                        Text(self.ocrTools[i].description())
                    }
                })
                
                resultText
                
                Spacer()
                
                Button(action: {
                    showImagePicker.toggle()
                }, label: {
                    Text("이미지 선택")
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                })
                .background(Color.blue)
                .foregroundColor(.white)
            }
            .navigationTitle(Text("OCR Scanner"))
            .sheet(isPresented: $showImagePicker) {
                PhotoPicker(sourceType: .photoLibrary) { image in
                    guard let sourceImage = image.scaledImage(1024) else {
                        return
                    }
                    
                    
                    ocrScanner.scan(sourceImage, completed: { result in
//                        resultText = Text(result)
                        resultImage = sourceImage
                        resultInfos = result
                        
                        showResult = true
                    })
                }
                
            }
            .sheet(isPresented: $showResult, content: {
                ResultView(resultImage: resultImage, resultInfos: resultInfos)
            })
        }
        .navigationTitle(Text("OCRScanner"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
