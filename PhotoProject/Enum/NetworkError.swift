//
//  NetworkError.swift
//  PhotoProject
//
//  Created by Claire on 1/22/25.
//

import Foundation

/*
 Common Status Codes    Description
 200 - OK    Everything worked as expected
 400 - Bad Request    The request was unacceptable, often due to missing a required parameter
 401 - Unauthorized    Invalid Access Token
 403 - Forbidden    Missing permissions to perform request
 404 - Not Found    The requested resource doesn’t exist
 500, 503    Something went wrong on our end
 */

enum NetworkError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case errorOnAPI = 500
    case unknown 
    
    var errorMessage: String {
        switch self {
        case .badRequest:
            "The request was unacceptable, often due to missing a required parameter"
        case .unauthorized:
            "Invalid Access Token"
        case .forbidden:
            "Missing permissions to perform request"
        case .notFound:
            "The requested resource doesn’t exist"
        case .errorOnAPI:
            "Something went wrong on end of API"
        case .unknown:
            "Unknown Error"
        }
    }
    
}
