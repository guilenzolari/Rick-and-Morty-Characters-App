import Foundation
import UIKit

// MARK: - Welcome
struct Welcome: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String?
}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case status = "status"
            case species = "species"
            case type = "type"
            case gender = "gender"
            case origin = "origin"
            case location = "location"
            case imageURL = "image"            
        }
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
