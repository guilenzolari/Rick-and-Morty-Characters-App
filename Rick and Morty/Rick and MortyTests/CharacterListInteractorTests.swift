//
//  CharacterListInteractorTests.swift
//  Rick and MortyTests
//
//  Created by Guilherme Ferreira Lenzolari on 23/01/25.
//

import XCTest
@testable import Rick_and_Morty

class MockAPIService: APIServiceProtocol {
    var shouldReturnError = false
    
    func fetchData<T>(urlString: String, completion: @escaping (Result<T, Rick_and_Morty.APIError>) -> ()) where T : Decodable, T : Encodable {
        if shouldReturnError {
            completion(.failure(.badURL))
        } else {
            let mockData = Welcome.stub()
            completion(.success(mockData as! T))
        }
        
    }
}

final class CharacterListInteractorTests: XCTestCase {
    var interactor: CharacterListInteractor!
    var mockAPIService: MockAPIService!

    //Given
    //When
    //Them
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        interactor = CharacterListInteractor(apiService: mockAPIService)
    }

    override func tearDown() {
        interactor = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_givenApiSuccess_whenFetchCharacterList_shouldReturnWelcome() {
        // Given
        var expectedResult: Welcome? = nil
        mockAPIService.shouldReturnError = false
        
        // When
        interactor.fetchCharacterList { (result: Result<Welcome, APIError>) in
            if case .success(let welcome) = result {
                expectedResult = welcome
            }
        }
        
        // Then
        XCTAssertEqual(expectedResult, Welcome.stub())
    }
    
    func testFetchCharacterListFailure() {
        mockAPIService.shouldReturnError = true
        
        interactor.fetchCharacterList { result in
            switch result {
            case .success(_):
                XCTFail("Expected fail, get success")
            case .failure(let error):
                XCTAssertEqual(error, .badURL)
            }
        }
    }
}
