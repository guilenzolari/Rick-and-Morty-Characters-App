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
    var sut: CharacterListInteractor!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        sut = CharacterListInteractor(apiService: mockAPIService)
    }

    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_givenApiSuccess_whenFetchCharacterList_shouldReturnWelcome() {
        // Given
        var expectedResult: Welcome? = nil
        mockAPIService.shouldReturnError = false
        
        // When
        sut.fetchCharacterList { (result: Result<Welcome, APIError>) in
            if case .success(let welcome) = result {
                expectedResult = welcome
            }
        }
        
        // Then
        XCTAssertEqual(expectedResult, Welcome.stub())
    }
    
    func testFetchCharacterListFailure() {
        //Given
        mockAPIService.shouldReturnError = true
        var expectedError: APIError? = nil
        
        
        // When
        sut.fetchCharacterList { result in
            if case .failure(let error) = result {
                expectedError = error
            }
        }
    
        // Then
        XCTAssertEqual(expectedError, .badURL)
    }
}
