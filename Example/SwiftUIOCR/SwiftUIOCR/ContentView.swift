//
//  ContentView.swift
//  SwiftUIOCR
//
//  Created by 이동근 on 2021/07/26.
//

import SwiftUI

struct ContentView: View {
    let ocrTools: [OCRTool] = [.Kakao, .Google]
    
    let ocrScanner: [OCRScanner] = [KakaoOCRScanner(), MLVisionOCRScanner()]
    
    @ObservedObject var resultState: OCRResultState = OCRResultState()
    
    @State private var showImagePicker = false
    @State private var showResult = false
    @State private var ocrTool = 0
    
    @State private var resultImage: UIImage = UIImage()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Picker(selection: $ocrTool, label: Text("OCR Tools"), content: {
                    ForEach(0 ..< ocrTools.count) { i in
                        Text(self.ocrTools[i].description())
                    }
                })
                
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
                    
                    ocrScanner[ocrTool].scan(sourceImage, completed: { result in
                        guard let result = result else {
                            return
                        }
                        
                        resultImage = sourceImage
                        resultState.result = result
                        DispatchQueue.main.async {
                            
                            showResult.toggle()
                        }
                    })
                }
            }
            .sheet(isPresented: $showResult, content: {
                ResultView(resultImage: resultImage, resultInfos: resultState.result)
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
