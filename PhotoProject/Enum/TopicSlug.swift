//
//  TopicSlug.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import Foundation

enum TopicSlug {
    case goldenHour
    case businessWork
    case architectureInterior
    
    var topicIDQuery: String {
        switch self {
        case .goldenHour: "golden-hour"
        case .businessWork: "business-work"
        case .architectureInterior: "architecture-interior"
        }
    }
}
