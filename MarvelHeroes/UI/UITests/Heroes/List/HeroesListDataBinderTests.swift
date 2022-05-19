//
//  HeroesListDataBinderTests.swift
//  UITests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Common
import Domain
import Nimble
import RxTest
import SwiftyMocky
import RxSwift
import RxBlocking

@testable import UI

final class HeroesListDataBinderTests: BaseTestCase {
    private var mapper: HeroesListItemUIMapperInterfaceMock!
    private var bag: DisposeBag!

    private var sut: HeroesListDataBinder!

    override func setUp() {
        super.setUp()
        mapper = HeroesListItemUIMapperInterfaceMock()
        bag = DisposeBag()
    }

    override func tearDown() {
        mapper = nil
        sut = nil
        bag = nil
        super.tearDown()
    }

    func initializeSut(state: Observable<HeroState>) {
        sut = HeroesListDataBinder(
            state: state,
            mapper: mapper
        )
    }
}

// MARK: - Tests
extension HeroesListDataBinderTests {
    func testTitle() {
        // Given
        initializeSut(state: .just(HeroesModelFactory.mockState))
        let expectedTitle = "Heroes"

        // When
        let data = sut.bind()

        // Then
        expect(data.title).to(equal(expectedTitle))
    }

    func testListItems() throws {
        // Given
        initializeSut(state: .just(HeroesModelFactory.mockState))
        Given(mapper, .map(from: .any, willReturn: []))

        // When
        let data = sut.bind()
        let _ = try data.listData.items
            .toBlocking(timeout: 5)
            .first()

        // Then
        Verify(mapper, 1, .map(from: .any))
    }
}
