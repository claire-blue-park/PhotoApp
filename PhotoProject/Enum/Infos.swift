//
//  Infos.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import Foundation

enum Infos {
    case infoNoResult
    case infoSearchPhoto
    
    var toString: String {
        switch self {
        case .infoNoResult: String(localized: "InfoNoResult")
        case .infoSearchPhoto: String(localized: "InfoSearchPhoto")
        }
    }
}
