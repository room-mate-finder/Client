//
//  Token.swift
//  finder-client
//
//  Created by Leeseojune on 2022/05/10.
//

import Foundation

struct Token: Codable {
    let accessToken: String
    let refreshToken: String
}
