//
//  LifeStyle.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/21.
//

import Foundation

enum LifeStyle: String, CaseIterable {
    case CLEAN = "깔끔"
    case USEFUL = "실용"
    
    static func stringToLifeStyle(value: String) -> LifeStyle {
        switch value {
        case "USEFUL":
            return LifeStyle.USEFUL
        default:
            return LifeStyle.CLEAN
        }
    }
}
