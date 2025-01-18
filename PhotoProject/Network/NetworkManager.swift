//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//
import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func callRequest() {
        let url = ""
        print("URL: \(url)")
        
//        AF.request(url, method: .get).validate(200...300).responseDecodable(of: ) { response in
//            <#code#>
//        }
    }
}
