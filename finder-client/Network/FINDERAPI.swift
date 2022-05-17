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
    case auth(_ number: String, _ password: String)
    case signUp(_ number: String, _ password: String, _ name: String)
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
        let baseUrl = "http://localhost:8080"
        return baseUrl + path
    }
    
    public var method: HTTPMethod {
        switch self {
        case .queryMyInformation,
                .queryRoomInformation,
                .queryRoomMate:
            return .get
        case .auth,
                .signUp,
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
        case .signUp(let number, let password, let name):
            return ["nubmer": number, "password": password, "name": name]
        case .auth(let number, let password):
            return ["number": number, "password": password]
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
        case .auth,
                .signUp:
            return nil
        case .tokenRefresh:
            return ["REFRESH-TOKEN": refreshToken]
        default:
            return [
                "Authorization": "Bearer \(accessToken)"
            ]
        }
    }
    
    private var path: String {
        switch self {
        case .signUp:
            return "/users/signup"
        case .auth,
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
