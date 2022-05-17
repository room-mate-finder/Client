//
//  AuthViewModel.swift
//  finder-client
//
//  Created by Leeseojune on 2022/05/09.
//

import Foundation
import Combine
import KeychainSwift

class AuthViewModel: ObservableObject {
    @Published var userId = ""
    @Published var password = ""
    
    func auth() {
        HTTPClient.instance.request(.auth(String(userId), String(password)), Token.self) {
            result in
            let keyChain = KeychainSwift()
            keyChain.set(result?.accessToken ?? "", forKey: "ACCESS-TOKEN")
            keyChain.set(result?.refreshToken ?? "", forKey: "REFRESH-TOKEN")
        }
    }
}
