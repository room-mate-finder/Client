//
//  HttpUtil.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/18.
//

import Foundation
import Alamofire

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
                do {
                    let result = try self?.decoder.decode(T.self, from: response.data!)
                    
                    completionHandler(result)
                }catch(let err) {
                    print(err)
                }
            }
    }
    
}
