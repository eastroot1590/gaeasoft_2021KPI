//
//  WifiImage.swift
//  SwiftUIDemo
//
//  Created by 이동근 on 2021/06/14.
//

import SwiftUI

struct WifiImage: View {
    @Binding var flag: Bool
    
    var body: some View {
        Image(systemName: flag ? "wifi" : "wifi.slash")
    }
}

//struct WifiImage_Previews: PreviewProvider {
//    static var previews: some View {
//        WifiImage(flag: false)
//    }
//}
