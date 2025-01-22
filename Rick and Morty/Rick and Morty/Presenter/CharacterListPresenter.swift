//
//  CharacterListPresenter.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 10/12/24.
//
import UIKit

protocol CharacterListPresenterProtocol {
    func fetchCharacters()
    func fetchCharacterImage(for character: Character, completion: @escaping (UIImage?) -> Void)
}

final class CharacterListPresenter: CharacterListPresenterProtocol {
    let interactor: CharacterListInteractorProtocol
    weak var viewController: CharacterListViewProtocol?
    var characters: [Character] = []
    var imageCache: [Int: UIImage] = [:]
    private var countOfPaginations: Int = 2
    
    init(
        interactor: CharacterListInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    func fetchCharacters() {
        interactor.fetchCharacterList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let welcome):
                self.handleSuccess(response: welcome)
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    private func handleSuccess(response: Welcome) {
        if countOfPaginations <= response.info.pages {
            countOfPaginations += 1
            characters.append(contentsOf: response.results)
            viewController?.updateCharacterList(with: response.results)
        }
    }
    
    
    private func handleError(error: Error) {
        self.viewController?.displayError(message: error.localizedDescription)
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
