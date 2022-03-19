//
//  FINDERAPI.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/18.
//

import Foundation
import Alamofire
import KeychainSwift

enum FINDERAPI {
    case queryLoginLink
    case auth(_ code: String)
    case tokenRefresh
    case updateMyInformation(_ lifeStyle: String, _ bedTime: String, _ wakeUpTime: String, _ description: String)
    case queryMyInformation
    
    case queryRoomInformation
    case updateRoomInformation(roomNumber: String, count: Int)
    case leaveRoom
    case queryRoomMate
    
    case sendInvite(number: String)
    case refuseInvite(number: String)
}

extension FINDERAPI {
    
    public var uri: String {
        let baseUrl = "https://finder.ddyzd.click"
        return baseUrl + path
    }
    
    public var method: HTTPMethod {
        switch self {
        case .queryLoginLink,
                .queryMyInformation,
                .queryRoomInformation,
                .queryRoomMate:
            return .get
        case .auth,
                .sendInvite:
            return .post
        case .tokenRefresh:
            return .put
        case .updateMyInformation,
                .updateRoomInformation:
            return .patch
        case .leaveRoom,
                .refuseInvite:
            return .delete
        }
    }
    
    public var parameter: Parameters? {
        switch self {
        case .auth(let code):
            return ["code": code]
        case .updateMyInformation(let lifeStyle, let bedTime, let wakeUpTime, let description):
            return [
                "life_style": lifeStyle,
                "bed_time": bedTime,
                "wake_up_time": wakeUpTime,
                "description": description
            ]
        case .sendInvite(let number),
                .refuseInvite(let number):
            return ["number": number]
        case .updateRoomInformation(let roomNumber, let count):
            return [
                "room_number": roomNumber,
                "count": count
            	]
        default:
            return nil
        }
    }
    
    public var encoding: ParameterEncoding {
        switch self.method {
        case .get:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }
    
    public var header: HTTPHeaders? {
        switch self {
        case .queryLoginLink,
                .auth:
            return nil
        case .tokenRefresh:
            return ["REFRESH-TOKEN": refreshToken]
        default:
            return ["Authroization": "Bearer \(accessToken)"]
        }
    }
    
    private var path: String {
        switch self {
        case .queryLoginLink,
            .auth(_),
            .tokenRefresh:
            return "/users/auth"
        case .updateMyInformation,
            .queryMyInformation:
            return "/users/information"
        case .queryRoomInformation,
            .updateRoomInformation:
            return "/rooms/information"
        case .leaveRoom:
            return "/rooms"
        case .queryRoomMate:
            return "/rooms/mates"
        case .sendInvite,
            .refuseInvite:
            return "/invite"
        @unknown default :
            return ""
        }
    }
    
    private var refreshToken: String {
        let keyChain = KeychainSwift()
        return keyChain.get("REFRESH-TOKEN") ?? ""
    }
    
    private var accessToken: String {
        let keyChain = KeychainSwift()
        return keyChain.get("ACCESS-TOKEN") ?? ""
    }
    
}
