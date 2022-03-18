//
//  ContentView.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/17.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack{
            NavigationView {
                NavigationLink {
                    UserView()
                } label: {
                    Text("Go to User")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
