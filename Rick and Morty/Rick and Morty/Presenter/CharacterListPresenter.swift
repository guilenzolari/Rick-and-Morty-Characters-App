//
//  CharacterListPresenter.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 10/12/24.
//

final class CharacterListPresenter: CharacterListPresenterProtocol {
    let interactor: CharacterListInteractorProtocol
    weak var viewController: CharacterListViewProtocol?
    var characters: [Character] = []
    
    init(
        interactor: CharacterListInteractorProtocol
    ) {
        self.interactor = interactor

    }
    
    func fetchCharacters() {
        interactor.fetchCharacterList { [weak self] result in
            switch result {
            case .success(let welcome):
                self?.characters = welcome.results
                self?.viewController?.updateCharacterList(with: welcome.results)
            case .failure(let error):
                self?.viewController?.displayError(message: error.localizedDescription)
            }
        }
    }
}

protocol CharacterListPresenterProtocol {
    
}
