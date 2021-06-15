//
//  ObservableSecondView.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/06/15.
//

import SwiftUI

struct ObservableSecondView: View {
    @EnvironmentObject var timerData: TimerData
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("타이머 : \(timerData.timerCount)")
                .padding()
        }
    }
}

struct ObservableSecondView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableSecondView().environmentObject(TimerData())
    }
}
