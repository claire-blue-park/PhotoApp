//
//  UnsplashRequest.swift
//  PhotoProject
//
//  Created by Claire on 1/21/25.
//

import UIKit
import Alamofire

enum UnsplashRequest {
    case topic(slug: TopicSlug, page:Int)
    case random(count: Int)
    case search(query: String, page: Int, sort: Sorts)
    case detail(id: String)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endPoint: URL{
        return switch self {
        case .topic(let slug, let page):
            URL(string: baseURL + "topics/\(slug.topicIDQuery)/photos?"
                                + "page=\(page)")!
        case .random(let count):
            URL(string: baseURL + "photos/random?"
                                + "count=\(count)")!
        case .search(let query, let page, let sort):
            URL(string: baseURL + "search/photos?"
                                + "page=\(page)&"
                                + "per_page=20&"
                                + "order_by=\(sort.sortQuery)&"
//                              + "color=\(color)&"
                                + "query=\(query)")!
        case .detail(let id):
            URL(string: baseURL + "photos/\(id)/statistics")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(APIKey.unsplash)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
