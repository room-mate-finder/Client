//
//  UserView.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/17.
//

import SwiftUI
import Combine
import KeychainSwift

struct UserView: View {
    @ObservedObject var viewModel = UserViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State
    var isLogout = false
    
    let keyChain = KeychainSwift()
    
    var body: some View {
        ScrollView {
            VStack {
                
                Spacer()
                
                Section(header: Text("내 타입")) {
                    Picker("내 타입", selection: $viewModel.lifeStyle) {
                        ForEach(LifeStyle.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 36)
                }
                
                Section(header: Text("취침 시간")) {
                    Picker("취침 시간", selection: $viewModel.bedTime) {
                        ForEach(Time.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 36)
                }
                
                Section(header: Text("기상 시간")) {
                    Picker("기상 시간", selection: $viewModel.wakeUpTime) {
                        ForEach(Time.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 36)
                }
                
                Section(header: Text("자기소개")) {
                    ZStack {
                        TextEditor(text: $viewModel.description)
                            .onReceive(viewModel.description.publisher.collect()) {
                                let s = String($0.prefix(200))
                                if viewModel.description != s {
                                    viewModel.description = s
                                }
                            }
                            .foregroundColor(.white)
                            .background(Color("Gray"))
                            .frame(width: 336, height: 190)
                            .cornerRadius(25)
                        
                        HStack {
                            Text(String(viewModel.description.count))
                                .fontWeight(.bold)
                            Text("/ 200")
                                .fontWeight(.bold)
                        }
                        .padding(.top, 160)
                        .padding(.leading, 240)
                        
                    }
                    .onAppear {
                        UITextView.appearance().backgroundColor = .clear
                    }
                    .padding(.bottom, 30)
                }
                .onTapGesture {
                    self.endTextEditing()
                }
                
                ZStack {
                    Image("Box")
                        .resizable()
                        .frame(width: 322, height: 57)
                    
                    Button {
                        viewModel.saveUserInformation()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("완료")
                            .font(.system(.title))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                }
                .padding(.bottom, 10)
                
                
            }
            .background(.black)
        }
        .onAppear {
            viewModel.queryUserInformation()
        }
        .navigationBarTitle("내 정보 수정", displayMode: .inline)
        .toolbar {
            Button {
                keyChain.set("", forKey: "ACCESS-TOKEN")
                keyChain.set("", forKey: "REFRESH-TOKEN")
                self.isLogout.toggle()
            } label: {
                Text("Logout")
            }
        }
        
        NavigationLink(destination: AuthView(), isActive: $isLogout) { }
    }
    
    
    func limitText() {
        if viewModel.description.count > 255 {
            viewModel.description = String(describing: viewModel.description.prefix(255))
        }
    }
    
}

extension UserView {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
