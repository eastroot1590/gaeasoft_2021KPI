//
//  ObservableView.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/06/15.
//

import SwiftUI
import Combine

struct ObservableView: View {
    @EnvironmentObject var timerData: TimerData
    
    var body: some View {
        NavigationView {
            VStack {
                Text("타이머 : \(timerData.timerCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Button(action: {
                    timerData.reset()
                }, label: {
                    Text("초기화")
                })
                
                NavigationLink(
                    destination: ObservableSecondView(),
                    label: {
                        Text("Second")
                    })
                    .padding()
            }
        }
    }
}

struct ObservableView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableView().environmentObject(TimerData())
    }
}
