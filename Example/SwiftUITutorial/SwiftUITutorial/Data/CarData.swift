//
//  CarData.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/07/05.
//

import UIKit
import SwiftUI

var carData: [Car] = loadJson("carData.json")

func loadJson<T>(_ fileName: String) -> T where T: Decodable {
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("\(fileName) not found.")
    }
    
    let data: Data
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(fileName): \(error)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(fileName): \(error)")
    }
}
