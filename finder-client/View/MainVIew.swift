//
//  ContentView.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/17.
//

import SwiftUI
import Combine

struct RoomMateView: View {
    @ObservedObject var viewModel = MainViewModel()
    
    var roomMate: RoomMate
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Gray"))
                .frame(width: 200, height: 300)
                .cornerRadius(10)
            VStack {
                HStack {
                    Text(roomMate.number)
                    Text(roomMate.name)
                    Button {
                        viewModel.sendInvite(number: roomMate.number)
                    } label: {
                        Image("Invite")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.bottom, 150)
                Text(roomMate.lifeStyle ?? "")
                Text(roomMate.bedTime ?? "")
                Text(roomMate.wakeUpTime ?? "")
                Text(roomMate.description ?? "")
            }
            
        }
    }
}

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Image("Logo")
                        .resizable()
                        .frame(width: 135, height: 35)
                        .padding(.leading, 14)
                        .padding(.bottom, 10)
                    Spacer()
                    NavigationLink {
                        UserView()
                    } label: {
                        Image("Customer")
                            .frame(width: 22, height: 28)
                            .padding(.trailing, 12)
                    }
                }
                .frame(width: 390, height: 50)
                .background(
                    Color("Header")
                )
                NavigationLink {
                    ChatView()
                } label: {
                    HStack {
                        Spacer()
                        ZStack {
                            Image("ChatIconBlock")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Image("Chat")
                                .resizable()
                                .frame(width: 26, height: 22)
                        }
                    }
                }
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(viewModel.roomMates, id: \.number) { roomMate in
                            HStack {
                                RoomMateView(roomMate: roomMate)
                            }
                        }
                    }
                    
                }
                .onAppear {
                    viewModel.queryRoomMate()
                }
                Spacer()
            }
            .background(.black)
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.portrait)
    }
}
