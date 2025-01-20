//
//  Sorts.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import Foundation

enum Sorts {
    case byLatest
    case byRelevance
    
    var toString: String {
        switch self {
        case .byLatest: String(localized: "ByLatest")
        case .byRelevance: String(localized: "ByRelevance")
        }
    }
    
    var sortQuery: String {
        switch self {
        case .byLatest: "latest"
        case .byRelevance: "relevant"
        }
    }
}
