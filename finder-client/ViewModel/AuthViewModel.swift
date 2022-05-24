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
    
    func auth() -> Bool {
        let keyChain = KeychainSwift()
        if(keyChain.get("ACCESS-TOKEN") != "") {
            return true
        }
        HTTPClient.instance.request(.auth(String(userId), String(password)), Token.self) {
            result in
            keyChain.set(result?.accessToken ?? "", forKey: "ACCESS-TOKEN")
            keyChain.set(result?.refreshToken ?? "", forKey: "REFRESH-TOKEN")
        }
        return keyChain.get("ACCESS-TOKEN") != ""
    }
}
