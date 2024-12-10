import Foundation
import UIKit

// MARK: - Welcome
struct Welcome {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String?
}

// MARK: - Result
struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
