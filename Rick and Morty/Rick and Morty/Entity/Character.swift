import Foundation
import UIKit

// MARK: - Welcome
struct Welcome: Equatable, Codable {
    let info: Info
    let results: [Character]
}

extension Welcome {
    static func stub(
        info: Info = .stub(),
        results: [Character] = []
    ) -> Welcome {
        return Welcome(info: info, results: results)
    }
}

// MARK: - Info
struct Info: Equatable, Codable {
    let count, pages: Int
    let next: String?
}

extension Info {
    static func stub(
        count: Int = 0,
        pages: Int = 0,
        next: String? = nil
    ) -> Info {
        return Info(count: count, pages: pages, next: next)
    }
}

// MARK: - Result
struct Character: Equatable, Codable {
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
struct Location: Equatable, Codable {
    let name: String
    let url: String
}
