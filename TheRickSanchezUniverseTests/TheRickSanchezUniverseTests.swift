//
//  TheRickSanchezUniverseTests.swift
//  TheRickSanchezUniverseTests
//
//  Created by Ahmed MAbdelfattah on 30/05/2024.
//

import XCTest
@testable import TheRickSanchezUniverse

class CharacterListViewModelTests: XCTestCase {
    var viewModel: CharactersListViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = CharactersListViewModel(charactersListAppState: .initial, networkManager: mockNetworkManager, stateDidUpdate: nil)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.charactersListAppState, .initial)
    }

    
    func testFetchCharactersFromFile() {
            let expectation = self.expectation(description: "Fetch Characters From File")

            viewModel.getCharactersList(with: "mockCharacters")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                var retrievedCharacters: [CharacterRepresentation] = []
                if case let .success(characters) = self.viewModel.charactersListAppState {
                    retrievedCharacters = characters
                }
                XCTAssertFalse(retrievedCharacters.isEmpty)
                XCTAssertEqual(retrievedCharacters.count, 14)
                XCTAssertEqual(retrievedCharacters.first?.name, "Abradolf Lincler")
                XCTAssertEqual(retrievedCharacters.last?.name, "Ants in my Eyes Johnson")
                expectation.fulfill()
            }

            waitForExpectations(timeout: 2.0, handler: nil)
        }
    
    func testEmptyFile() {
            let expectation = self.expectation(description: "Fetch Characters From File")

            viewModel.getCharactersList(with: "EmptyCharactersList")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                var retrievedCharacters: [CharacterRepresentation] = []
                if case let .success(characters) = self.viewModel.charactersListAppState {
                    retrievedCharacters = characters
                }
                XCTAssertTrue(retrievedCharacters.isEmpty)
                XCTAssertEqual(retrievedCharacters.count, 0)
                XCTAssertNil(retrievedCharacters.first?.name)
                
                XCTAssertNil(retrievedCharacters.last?.name)
                expectation.fulfill()
            }

            waitForExpectations(timeout: 2.0, handler: nil)
        }

}
