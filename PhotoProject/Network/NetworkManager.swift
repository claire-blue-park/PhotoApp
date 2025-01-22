//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func callRequest<T: Decodable>(api: UnsplashRequest,
                                   completionHandler: @escaping (T) -> Void,
                                   failureHandler: @escaping (_ code: Int?, _ message: String) -> Void) {
        AF.request(api.endPoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    if let responseCode = error.responseCode {
                        let message = NetworkError(rawValue: responseCode)?.errorMessage
                                   ?? NetworkError.unknown.errorMessage
                        failureHandler(responseCode, message)
                    }
                    failureHandler(-1, "No ResponseCode")
                }
            }
    }
}
