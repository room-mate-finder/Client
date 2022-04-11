//
//  UserViewModel.swift
//  finder-client
//
//  Created by Leeseojune on 2022/04/11.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    @Published var lifeStyle = LifeStyle.CLEAN
    @Published var bedTime = Time.EARLY
    @Published var wakeUpTime = Time.EARLY
    @Published var description: String = ""
    
    func saveUserInformation() {
                                     HTTPClient.instance.request(.updateMyInformation(String(describing: lifeStyle), String(describing: bedTime), String(describing: wakeUpTime), description), RoomMateList.self) {result in
                                         
                                     }
                                 }
    
    func queryUserInformation() {
        HTTPClient.instance.request(.queryMyInformation, UserInformation.self) { [weak self]
            (result: UserInformation?) in
            self?.lifeStyle = LifeStyle.stringToLifeStyle(value: result?.lifeStyle ?? "CLEAN")
            self?.bedTime = Time.stringToTime(value: result?.bedTime ?? "EARLY")
            self?.wakeUpTime = Time.stringToTime(value: result?.wakeUpTime ?? "EARLY")
            self?.description = result?.description ?? ""
        }
    }
    
}
