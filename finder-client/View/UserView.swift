//
//  UserView.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/17.
//

import SwiftUI

struct UserView: View {
    @State private var lifeStyle = LifeStyle.CLEAN
    @State private var bedTime = Time.EARLY
    @State private var wakeUpTime = Time.EARLY
    @State private var description: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text("내 정보 수정")
                    .font(.system(.title2))
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                Section(header: Text("내 타입")) {
                    Picker("내 타입", selection: $lifeStyle) {
                        ForEach(LifeStyle.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 36)
                }
                
                Section(header: Text("취침 시간")) {
                    Picker("취침 시간", selection: $bedTime) {
                        ForEach(Time.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 36)
                }
                
                Section(header: Text("기상 시간")) {
                    Picker("기상 시간", selection: $wakeUpTime) {
                        ForEach(Time.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 36)
                }
                
                Section(header: Text("자기소개")) {
                    ZStack {
                        TextEditor(text: $description)
                            .onReceive(description.publisher.collect()) {
                                let s = String($0.prefix(200))
                                if description != s {
                                    description = s
                                }
                            }
                            .foregroundColor(.white)
                            .background(Color("Gray"))
                            .frame(width: 336, height: 190)
                            .cornerRadius(25)
                        
                        HStack {
                            Text(String(description.count))
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
                    
                    Text("완료")
                        .font(.system(.title))
                        .fontWeight(.bold)
                }
                .padding(.bottom, 10)
                
                
            }
            .background(.black)
        }
        
        
    }
    
    func limitText() {
        if description.count > 255 {
            description = String(describing: description.prefix(255))
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
