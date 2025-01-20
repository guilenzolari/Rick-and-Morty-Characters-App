//
//  CharacterListPresenter.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 10/12/24.
//
import UIKit

final class CharacterListPresenter: CharacterListPresenterProtocol {
    let interactor: CharacterListInteractorProtocol
    weak var viewController: CharacterListViewProtocol?
    var characters: [Character] = []
    var imageCache: [Int: UIImage] = [:]
    
    init(
        interactor: CharacterListInteractorProtocol
    ) {
        self.interactor = interactor
        
    }
    
    func fetchCharacters() {
        interactor.fetchCharacterList { [weak self] result in
            switch result {
            case .success(let welcome):
                self?.characters.append(contentsOf: welcome.results)
                self?.viewController?.updateCharacterList(with: welcome.results)
            case .failure(let error):
                print("falho: \(error)")
                self?.viewController?.displayError(message: error.localizedDescription)
            }
        }
    }
    
    func fetchCharacterImage(for character: Character, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache[character.id] {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: character.imageURL) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.imageCache[character.id] = image
            completion(image)
        }
        task.resume()
    }
    
}

protocol CharacterListPresenterProtocol {
    func fetchCharacters()
    func fetchCharacterImage(for character: Character, completion: @escaping (UIImage?) -> Void)
}
