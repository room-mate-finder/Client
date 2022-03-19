//
//  ContentView.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/17.
//

import SwiftUI
import Combine

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack{
            NavigationView {
                NavigationLink {
                    UserView()
                } label: {
                    Text("Go to User")
                }
            }
            List(viewModel.roomMates, id: \.number) { roomMate in
                HStack {
                    Text(roomMate.number)
                    Spacer()
                    Text(roomMate.name)
                }
            }.onAppear {
                viewModel.queryRoomMate()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
