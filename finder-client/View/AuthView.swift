//
//  AuthView.swift
//  finder-client
//
//  Created by Leeseojune on 2022/05/09.
//

import SwiftUI
import Combine

struct AuthView: View {
    @ObservedObject var viewModel = AuthViewModel()
    
    @State var isSignIn = false
    var body: some View {
        NavigationView {
            VStack {
                TextField("User Id", text: $viewModel.userId)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .padding(.bottom)
                
                SecureField("Password", text: $viewModel.password)
                    .keyboardType(.alphabet)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .padding(.bottom)
                
                NavigationLink(isActive: $isSignIn) {
                    MainView()
                } label: {
                    Button {
                        isSignIn = true
                        viewModel.auth()
                    } label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                    }
                }
                
                
                HStack {
                    Text("Don't you have an account?")
                        .foregroundColor(.gray)
                    Button {
                        
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(.mint)
                    }
                }
                
            }
        }
        
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
