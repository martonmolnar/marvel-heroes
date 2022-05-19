//
//  HeroDetailsUIMapperTests.swift
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

final class HeroDetailsUIMapperTests: BaseTestCase {
    private var sut: HeroDetailsUIMapperInterface!

    override func setUp() {
        super.setUp()
        sut = HeroDetailsUIMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension HeroDetailsUIMapperTests {
    func testList() throws {
        // Given
        let hero = HeroesModelFactory.mockHero

        let expectedName = "name"
        let expectedDescription = "description"
        // Then
        let data = sut.mapDetails(from: .just(hero))

        // When
        let name = try data.name.toBlocking(timeout: 10).first()
        let description = try data.description.toBlocking(timeout: 10).first()
        expect(name).to(equal(expectedName))
        expect(description).to(equal(expectedDescription))
    }
}
