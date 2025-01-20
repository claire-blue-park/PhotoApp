//
//  Statistics.swift
//  PhotoProject
//
//  Created by Claire on 1/20/25.
//

import Foundation

struct Statistics: Decodable {
    let downloads: Downloads
    let views: Views
}

struct Downloads: Decodable {
    let total: Int
    let historical: History
}

struct Views: Decodable {
    let total: Int
    let historical: History
}

struct History: Decodable {
    let values: [Values] // 30일간 다운로드 or 조회수 통계
}

struct Values: Decodable {
    let date: String
    let value: Int // 날짜별 다운로드 or 조회수 수
}
