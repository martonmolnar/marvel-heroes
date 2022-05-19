//
//  HeroesListItemMapperTests.swift
//  CoreTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Nimble
import Domain
import Common

@testable import Core

enum MapperError: Error {
    case itemNotFound
}

//// MARK: Definition
final class HeroesListItemMapperTests: BaseTestCase {
    var sut: DefaultHeroesListItemMapper!

    override func setUp() {
        super.setUp()
        sut = DefaultHeroesListItemMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: Tests
extension HeroesListItemMapperTests {
    func testMapping() {
        // Given
        let mockApiModels = HeroesModelFactory.makeHeroesResponseApiModel().heroes

        // When
        let results = sut.map(from: mockApiModels)
        guard let mockApiModel = mockApiModels.first,
              let result = results.first else {
                  fail("Mapping failed: no object was found in the result produced by the mapper.")
                  return
              }

        // Then
        expect(result.id).to(equal(mockApiModel.id))
        expect(result.name).to(equal(mockApiModel.name))
        expect(result.description).to(equal(mockApiModel.description))
        expect(result.imageUri).to(equal(mockApiModel.imageUri!.absoluteString))
    }
}

