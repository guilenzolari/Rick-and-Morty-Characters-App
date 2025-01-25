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

    func testFetchDataSuccess()  {
        let urlString = "https://rickandmortyapi.com/api/character"
        let expectation = expectation(description: "Fetch data success")
        
        sut.fetchData(urlString: urlString) { (result: Result<Welcome, APIError>) in
            switch result {
            case .success(let welcome):
                XCTAssertNotNil(welcome)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Expected success get failure")
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchDataFailureWithBadURL() {
        let urlString = ""
        let expectation = expectation(description: "fetch data with bad URL")
        
        sut.fetchData(urlString: urlString) { (result: Result<Welcome, APIError>) in
            switch result {
            case .success(_):
                XCTFail("Expected error got success")
            case .failure(let error):
                XCTAssertEqual(error, .badURL)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchDataFailureWithInvalidEndpoint() {
        let urlString = "https://rickandmortyapi.com/api/invalid-endpoint"
        let expectation = expectation(description: "fetch data with bad URL")
        
        sut.fetchData(urlString: urlString) { (result: Result<Welcome, APIError>) in
            switch result {
            case .success(_):
                XCTFail("Expected error got success")
            case .failure(let error):
                XCTAssertEqual(error, .badResponse(404))
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
}
