//
//  Topics.swift
//  PhotoProject
//
//  Created by Claire on 1/19/25.
//

import Foundation

struct SearchList: Decodable {
    let total: Int
    let results: [Results]
}

struct Results: Decodable {
    let id: String
    let createdAt: String
    let width: Int
    let height: Int
    let urls: PhotoUrls
    let likes: Int
    let user: PhotoUser
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case urls
        case likes
        case user
    }
}

struct PhotoUrls: Decodable {
    let raw: String
    let small: String
    let thumb: String
}

struct ProfilePhotoUrls: Decodable {
    let medium: String
}

struct PhotoUser: Decodable {
    let name: String
    let profileImage: ProfilePhotoUrls
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}
