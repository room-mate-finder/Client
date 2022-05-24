//
//  finder_clientApp.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/14.
//

import SwiftUI
import KeychainSwift

@main
struct finder_clientApp: App {
    var body: some Scene {
        let keyChain = KeychainSwift()
        WindowGroup {
            if(keyChain.get("ACCESS-TOKEN") != "") {
                MainView()
            } else {
                AuthView()
            }
        }
    }
}
