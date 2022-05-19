//
//  HeroesListItemUIMapperTests.swift
//  UITests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Common
import Domain
import Nimble
import RxSwift
import SwiftyMocky

@testable import UI

final class HeroesListItemUIMapperTests: BaseTestCase {
    private var sut: HeroesListItemUIMapperInterface!

    override func setUp() {
        super.setUp()
        sut = DefaultHeroesListItemUIMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension HeroesListItemUIMapperTests {
    func testList() {
        // Given
        var state = HeroesModelFactory.mockState
        state.heroes = .success([ HeroesModelFactory.mockHero ])

        let expectedValue = "name"

        // Then
        let data = sut.map(from: state)

        // When
        let cellData = data?.first
        expect(cellData?.title).to(equal(expectedValue))
    }
}
