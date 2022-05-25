//
//  HttpUtil.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/18.
//

import Foundation
import Alamofire
import KeychainSwift

class HTTPClient {
    static let instance = HTTPClient()
    private let decoder = JSONDecoder()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func request<T: Codable>(_ api: FINDERAPI, _ networkModel: T.Type, completionHandler: @escaping  (_ result: T?) -> ()) {
        AF.request(api.uri, method: api.method, parameters: api.parameter, encoding: api.encoding, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { [weak self] response in
                switch response.response?.statusCode {
                case 200, 201:
                    do {
                        let result = try self?.decoder.decode(T.self, from: response.data!)
                        completionHandler(result)
                    } catch(let err) {
                        print(err)
                    }
                case 401, 403:
                    let keyChain = KeychainSwift()
                    HTTPClient.instance.request(.tokenRefresh, Token.self) {
                        result in
                        keyChain.set(result?.accessToken ?? "", forKey: "ACCESS-TOKEN")
                        keyChain.set(result?.refreshToken ?? "", forKey: "REFRESH-TOKEN")
                    }
                default:
                    print(response.response?.statusCode)
                    print(response.response)
                }
                
            }
    }
    
}
