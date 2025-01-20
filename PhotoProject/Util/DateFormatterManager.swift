//
//  DateFormatterManager.swift
//  PhotoProject
//
//  Created by Claire on 1/18/25.
//

import UIKit

class DateFormatterManager {
    
    static let shared = DateFormatterManager()
    private static let dateFormatter = DateFormatter()
    private init() { }
    
    func getDateFormat(_ date: String, completionHandler: @escaping (String) -> Void){ // 2025-01-03T15:27:32Z
        print(date)
        DateFormatterManager.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let temp = DateFormatterManager.dateFormatter.date(from: date) ?? Date()
        DateFormatterManager.dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let formattedDate = DateFormatterManager.dateFormatter.string(from: temp)
        completionHandler(formattedDate)
    }

}
