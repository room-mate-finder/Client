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
        NavigationView {
            VStack{
                HStack {
                    
                    Image("logo")
                        .frame(width: 135, height: 54.85)
                    Spacer()
                    NavigationLink {
                        UserView()
                    } label: {
                        Image("customer")
                            .frame(width: 22, height: 28)
                            .padding(.trailing, 12)
                    }
                    .navigationBarHidden(true)
                }
                .background(
                    Rectangle()
                        .fill(Color("header"))
                        .frame(width: 390, height: 85)
                )
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(viewModel.roomMates, id: \.number) { roomMate in
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.portrait)
    }
}
