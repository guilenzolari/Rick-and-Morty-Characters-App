//
//  CharacterListPresenterTests.swift
//  Rick and MortyTests
//
//  Created by Guilherme Ferreira Lenzolari on 24/01/25.
//

import XCTest
@testable import Rick_and_Morty

class MockCharacterListInteractor: CharacterListInteractorProtocol {
    var shouldReturnError = false
    
    func fetchCharacterList(completion: @escaping (Result<Rick_and_Morty.Welcome, Rick_and_Morty.APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.badURL))
        } else {
            let mockData = Welcome(info: Info(count: 0, pages: 1, next: nil), results: [])
            completion(.success(mockData))
        }
    }
}

class MockCharacterListView: CharacterListViewProtocol {
    var didUpdateCharacterListCalled = false
    var didDisplayErrorCalled = false
    
    func updateCharacterList(with characters: [Rick_and_Morty.Character]) {
        self.didUpdateCharacterListCalled = true
    }
    
    func displayError(message: String) {
        self.didDisplayErrorCalled = true
    }
}

class MockCacheService: CacheServiceProtocol {
    var storedImage: UIImage?
    
    func setCharacter(value: Rick_and_Morty.Character, for key: Int) {}
    func getCharacter(for key: Int) -> Rick_and_Morty.Character? { return nil }
    func setImage(value: UIImage, for key: Int) {storedImage = value}
    func getImage(for key: Int) -> UIImage? { return storedImage }
}

final class CharacterListPresenterTests: XCTestCase {
    var sut: CharacterListPresenter!
    var mockInteractor: MockCharacterListInteractor!
    var mockCacheService: MockCacheService!
    var mockViewController: MockCharacterListView!
    
    
    override func setUp() {
        super.setUp()
        mockInteractor = MockCharacterListInteractor()
        mockCacheService = MockCacheService()
        mockViewController = MockCharacterListView()
        sut = CharacterListPresenter(interactor: mockInteractor, cache: mockCacheService)
        sut.viewController = mockViewController
    }

    override func tearDown() {
        mockInteractor = nil
        mockCacheService = nil
        mockViewController = nil
        super.tearDown()
    }

    func testFetchCharacterSuccess() {
        mockInteractor.shouldReturnError = false
        sut.fetchCharacters()
        
        XCTAssertTrue(mockViewController.didUpdateCharacterListCalled, "updateCharacterList should be called on success")
        XCTAssertEqual(sut.characters.count, 0, "The characters array should be updated correctly")
    }
    
    func testFetchCharactersFalure() {
        mockInteractor.shouldReturnError = true
        sut.fetchCharacters()
        
        XCTAssertTrue(mockViewController.didDisplayErrorCalled, "displayError should be called on failure")
    }
    
    func fetchCharacterImageSuccess(){
        
    }
    
    func testFetchCharacterImageAlreadyInCache(){
        let image = UIImage(named: "Rick")!
        mockCacheService.setImage(value: image, for: 0)
        let character = Rick_and_Morty.Character(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: Rick_and_Morty.Location(name: "", url: ""), location: Rick_and_Morty.Location(name: "", url: ""), imageURL: "")
        
        var fetchedImage: UIImage?
        
        sut.fetchCharacterImage(for: character) { image in
            fetchedImage = image
        }
        
        XCTAssertEqual(image, fetchedImage)
        
    }
    
    func testFetchCharacterImageInvalidURL() {
        let character = Rick_and_Morty.Character(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Rick_and_Morty.Location(name: "", url: ""), location: Rick_and_Morty.Location(name: "", url: ""), imageURL: "")
        
        var fetchedError: String?
        let expectation = expectation(description: "Invalide URL")
        
        
        sut.fetchCharacterImage(for: character) { _ in
            fetchedError = self.mockViewController.didDisplayErrorCalled ? "Error" : "validURL"
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(self.mockViewController.didDisplayErrorCalled, "Error should be called")
        XCTAssertEqual("Error", fetchedError)

    }
    
    func fetchCharacterImageURLSessionError(){
        
    }
}
