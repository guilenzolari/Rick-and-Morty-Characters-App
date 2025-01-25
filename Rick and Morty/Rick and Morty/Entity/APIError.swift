//
//  APIError.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 10/12/24.
//

import Foundation

enum APIError: Error, CustomStringConvertible, Equatable {
    
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
            case .badURL:
                return "badURL"
            case .urlSession(let error):
                return "urlSession error: \(error.debugDescription)"
            case .badResponse(let statusCode):
                return "bad response with status code: \(statusCode)"
            case .decoding(let decodingError):
            return "decoding error: \(String(describing: decodingError))"
            case .unknown:
                return "unknown error"
        }
    }
    
    var localizedDescription: String {
        switch self {
            case .badURL, .unknown:
               return "something went wrong"
            case .urlSession(let urlError):
                return urlError?.localizedDescription ?? "something went wrong"
            case .badResponse(_):
                return "something went wrong"
            case .decoding(let decodingError):
                return decodingError?.localizedDescription ?? "something went wrong"
        }
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL):
            return true
        case (.urlSession(let lhsError), .urlSession(let rhsError)):
            return lhsError == rhsError
        case (.badResponse(let lhsCode), .badResponse(let rhsCode)):
            return lhsCode == rhsCode
        case (.decoding(let lhsDecodingError), .decoding(let rhsDecodingError)):
            return lhsDecodingError?.localizedDescription == rhsDecodingError?.localizedDescription
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
    
}
