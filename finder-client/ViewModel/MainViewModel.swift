//
//  MainViewModel.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/18.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    func queryRoomMate() -> Array<RoomMate> {
        return [RoomMate(id: 0, number: "3211", name: "이서준", description: nil, lifeStyle: "CLEAN", bedTime: "EALRY", wakeUpTime: "OTHER")]
    }
    
}
