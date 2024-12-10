//
//  APIService.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 10/12/24.
//

import Foundation

class APIService: APIServiceProtocol {
    
    init(url: String) {
        self.url = url
    }
    
    private let url: String
    
    public func fetchData<T: Decodable>(completion: @escaping (Result<[T], APIError>) -> () ){
        
        guard let url = URL(string: url) else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.urlSession(error)))
                return }
            
            if let response = response as? HTTPURLResponse,
                !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(response.statusCode)))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode([T].self, from: data)
                        completion(Result.success(result))
                } catch {
                    completion(Result.failure(.decoding(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}

protocol APIServiceProtocol {
    func fetchData<T: Decodable>(completion: @escaping (Result<[T], APIError>) -> ())
}
