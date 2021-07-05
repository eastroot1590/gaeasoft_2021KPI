//
//  MainListView.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/06/15.
//

import SwiftUI

struct MainListView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: BasicLayout(),
                    label: {
                        Text("Basic Layout")
                    })
                
                NavigationLink(
                    destination: ObservableView().environmentObject(TimerData()),
                    label: {
                        Text("Observable")
                    })
            }
            .navigationBarTitle("Main List")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
