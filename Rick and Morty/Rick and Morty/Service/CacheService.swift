//
//  CacheService.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 22/01/25.
//

import Foundation
import UIKit

protocol CacheServiceProtocol {
    func setCharacter(value: Character, for key: Int)
    func getCharacter(for key: Int) -> Character?
    func setImage(value: UIImage, for key: Int)
    func getImage(for key: Int) -> UIImage?
}

final class CacheService: CacheServiceProtocol {
    let charactersCache = NSCache<NSNumber, NSData>()
    let imagesCache = NSCache<NSNumber, UIImage>()
    
    init(maxItems: Int = 300, maxCost: Int = 0) {
        charactersCache.countLimit = maxItems
        charactersCache.totalCostLimit = maxCost
        imagesCache.countLimit = maxItems
        imagesCache.totalCostLimit = maxCost
    }

    func setCharacter(value: Character, for key: Int) {
        do {
            let data = try JSONEncoder().encode(value)
            charactersCache.setObject(data as NSData, forKey: NSNumber(value: key))
        } catch {
            print("Failed to encode Character: \(error)")
        }
    }
    
    func getCharacter(for key: Int) -> Character? {
        guard let data = charactersCache.object(forKey: NSNumber(value: key)) as Data? else {
            return nil
        }
        do {
            return try JSONDecoder().decode(Character.self, from: data)
        } catch {
            print("Failed to decode Character: \(error)")
            return nil
        }
    }
    
    func setImage(value: UIImage, for key: Int) {
        imagesCache.setObject(value, forKey: NSNumber(value: key), cost: 0)
    }
    
    func getImage(for key: Int) -> UIImage? {
        return imagesCache.object(forKey: NSNumber(value: key))
    }

}
