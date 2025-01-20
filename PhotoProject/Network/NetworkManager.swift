//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func callRequestForTopic(topicSlug: TopicSlug, page: Int, completionHandler: @escaping ([Results]) -> Void) {

        let url: String = "https://api.unsplash.com/topics/\(topicSlug.topicIDQuery)/photos?"
                        + "page=\(page)&"
                        + "client_id=\(APIKey.unsplash)"

        AF.request(url, method: .get).responseDecodable(of: [Results].self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callRequestForSearch(query: String, page: Int, sort: Sorts, completionHandler: @escaping (SearchList) -> Void) {

        let url: String = "https://api.unsplash.com/search/photos?"
                        + "page=\(page)&"
                        + "per_page=20&"
                        + "order_by=\(sort.sortQuery)&"
//                        + "color=\(color)&"
                        + "query=\(query)&"
                        + "client_id=\(APIKey.unsplash)"

        AF.request(url, method: .get).responseDecodable(of: SearchList.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callRequestForDetail(imageId: String, completionHandler: @escaping (Statistics) -> Void) {

        let url: String = "https://api.unsplash.com/photos/\(imageId)/statistics?"
                        + "client_id=\(APIKey.unsplash)"

        AF.request(url, method: .get).responseDecodable(of: Statistics.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
