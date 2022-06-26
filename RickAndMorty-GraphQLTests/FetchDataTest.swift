//
//  FetchDataTest.swift
//  RickAndMorty-GraphQLTests
//
//  Created by Mert Gökduman on 26.06.2022.
//

import XCTest

@testable import RickAndMorty_GraphQL
class FetchDataTest: XCTestCase {
    
    func testAllCharactersFetch() throws {
        let expectation = self.expectation(description: "Fetching All Character Data Test")
        
        let response = CharacterQuery.Data.Character.Result(id: "3",
                                                            name: "Summer Smith",
                                                            location: CharacterQuery.Data.Character.Result.Location(name:"Earth (Replacement Dimension)"),
                                                            image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")
        
        Network.shared.apollo.fetch(query: CharacterQuery(page: 1, charaterName: "")) { result in
            
            switch result {
                
            case let .success(result):
                guard let result = result.data?.characters?.results else { return }
                XCTAssertEqual(response, result[2])
                expectation.fulfill()
                
            case .failure( _):
                expectation.fulfill()
                XCTFail("Fething All Characters Data is failed")
            }
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRichDataFetch() throws {
        let expectation = self.expectation(description: "Fetching Rick Data Test")
        
        let response = CharacterQuery.Data.Character.Result(id: "1",
                                                            name: "Rick Sanchez",
                                                            location: CharacterQuery.Data.Character.Result.Location(name: "Citadel of Ricks"),
                                                            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        
        Network.shared.apollo.fetch(query: CharacterQuery(page: 1, charaterName: "Rick")) { result in
            
            switch result {
            case let .success(result):
                guard let result = result.data?.characters?.results else { return }
                XCTAssertEqual(response, result.first)
                expectation.fulfill()
            case .failure(_):
                expectation.fulfill()
                XCTFail("Fething Rick Data is failed")
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testMortyDataFetch() throws {
        let expectation = self.expectation(description: "Fetching Rick Data Test")
        
        let response = CharacterQuery.Data.Character.Result(id: "2",
                                                            name: "Morty Smith",
                                                            location: CharacterQuery.Data.Character.Result.Location(name: "Citadel of Ricks"),
                                                            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
        
        Network.shared.apollo.fetch(query: CharacterQuery(page: 1, charaterName: "Morty")) { result in
            
            switch result {
            case let .success(result):
                guard let result = result.data?.characters?.results else { return }
                XCTAssertEqual(response, result.first)
                expectation.fulfill()
            case .failure(_):
                expectation.fulfill()
                XCTFail("Fething Rick Data is failed")
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
