//
//  SwiftUIOCRApp.swift
//  SwiftUIOCR
//
//  Created by 이동근 on 2021/07/26.
//

import SwiftUI
import Firebase

@main
struct SwiftUIOCRApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
