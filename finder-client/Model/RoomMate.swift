//
//  RoomMate.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/18.
//

import Foundation

struct RoomMateList: Codable {
    let mates: [RoomMate]
}

struct RoomMate: Codable {
    let number: String
    let name: String
    let description: String?
    let lifeStyle: String?
    let bedTime: String?
    let wakeUpTime: String?
}
