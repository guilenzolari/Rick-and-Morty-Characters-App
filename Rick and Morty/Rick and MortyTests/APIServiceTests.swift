//
//  APIServiceTests.swift
//  Rick and MortyTests
//
//  Created by Guilherme Ferreira Lenzolari on 23/01/25.
//

import XCTest
@testable import Rick_and_Morty


final class APIServiceTests: XCTestCase {
    var sut : APIService! //sut = system under test
    
    override func setUp() {
        super.setUp()
        sut = APIService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_givenApiSuccess_whenFetchCharacterList_shouldReturnWelcome()  {
        // Given
        let urlString = "https://rickandmortyapi.com/api/character"
        var expectedResult: Welcome? = nil
        let expectation = expectation(description: "Fetch data success")
        
        // When
        sut.fetchData(urlString: urlString) { (result: Result<Welcome, APIError>) in
            if case .success(let welcome) = result {
                expectedResult = welcome
                expectation.fulfill()
            }
        }
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(expectedResult, "Result should not be nil")
        
    }
    
    
    func test_givenAPIFailure_whenURLIsInvalid_shouldReturnBardUrlError() {
        // Given
        let urlString = ""
        var expectedError: APIError? = nil
        
        // When
        sut.fetchData(urlString: urlString) { (result: Result<Welcome, APIError>) in
            if case . failure(let failure) = result {
                expectedError = failure
            }
        }
        
        //Then
        XCTAssertEqual(expectedError, .badURL)
    }
    
    func test_givenAPIFailure_whenEndpointIsInvalid_shouldReturnBadResponseError() {
        // Given
        let urlString = "https://rickandmortyapi.com/api/invalid-endpoint"
        var expectedError: APIError? = nil
        let expectation = expectation(description: "Bad response error")
        
        // When
        sut.fetchData(urlString: urlString) { (result: Result<Welcome, APIError>) in
            if case .failure(let failure) = result {
                expectedError = failure
                expectation.fulfill()
            }
        }

        // Then
        waitForExpectations(timeout: 5)
        XCTAssertEqual(expectedError, .badResponse(404))
    }
}
