//
//  CharacterListInteractor.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 10/12/24.
//

protocol CharacterListInteractorProtocol: AnyObject {
    func fetchCharacterList(completion: @escaping (Result<Welcome, APIError>) -> Void)
}

final class CharacterListInteractor: CharacterListInteractorProtocol {
    var apiService: APIServiceProtocol
    var nextEndpoint: String?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        self.nextEndpoint = Endpoint.character.rawValue
    }
    
    func fetchCharacterList(completion: @escaping (Result<Welcome, APIError>) -> Void) {
        guard let currentEndpoint = self.nextEndpoint else {
            completion(.failure(.badURL))
            return
        }
        
        apiService.fetchData(urlString: currentEndpoint) { [weak self] (result: Result<Welcome, APIError>) in
            switch result {
            case .success(let welcome):
                self?.nextEndpoint = welcome.info.next
                completion(.success(welcome))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum Endpoint: String {
    case character = "https://rickandmortyapi.com/api/character"
}

