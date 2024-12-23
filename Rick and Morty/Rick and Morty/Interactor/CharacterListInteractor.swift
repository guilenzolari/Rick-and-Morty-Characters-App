//
//  CharacterListInteractor.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 10/12/24.
//

final class CharacterListInteractor: CharacterListInteractorProtocol {
    private var apiService: APIServiceProtocol
    var presenter: CharacterListPresenterProtocol?
    
    init(apiService: APIServiceProtocol = APIService(url: Endpoint.character.rawValue)) {
        self.apiService = apiService
    }
    
    func fetchCharacterList(completion: @escaping (Result<Welcome, APIError>) -> Void) {
        apiService.fetchData { [weak self] (result: Result<Welcome, APIError>) in
            switch result {
            case .success(let welcome):
                if let nextEndpoint = welcome.info.next {
                    self?.apiService.urlString = nextEndpoint
                }
                completion(.success(welcome))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

protocol CharacterListInteractorProtocol: AnyObject {
    func fetchCharacterList(completion: @escaping (Result<Welcome, APIError>) -> Void)
}
