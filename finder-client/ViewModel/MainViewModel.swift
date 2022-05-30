//
//  MainViewModel.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/18.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    @Published var roomMates = [RoomMate]()
    
    func queryRoomMate() {
        HTTPClient.instance.request(.queryRoomMate, RoomMateList.self) { [weak self] (result: RoomMateList?) in
            self?.roomMates = result?.mates ?? []
        }
    }
    
    func sendInvite(number: String) {
        HTTPClient.instance.request(.sendInvite(number: number), RoomMateList.self) { result in }
    }
    
}
