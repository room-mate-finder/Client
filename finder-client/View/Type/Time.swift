//
//  Time.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/21.
//

import Foundation

enum Time: String, CaseIterable {
    case EARLY = "일찍"
    case LATE = "늦게"
    case OTHER = "이 외"
    
    static func stringToTime(value: String) -> Time {
        switch value {
        case "LATE":
            return Time.LATE
        case "OTHER":
            return Time.OTHER
        default:
            return Time.EARLY
        }
    }
}
