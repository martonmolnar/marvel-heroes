//
//  HeroDetailsDataBinderTests.swift
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

final class HeroDetailsDataBinderTests: BaseTestCase {
    private var mapper: HeroDetailsUIMapperInterfaceMock!
    private var bag: DisposeBag!

    private var sut: HeroDetailsDataBinder!

    override func setUp() {
        super.setUp()
        mapper = HeroDetailsUIMapperInterfaceMock()
        bag = DisposeBag()
    }

    override func tearDown() {
        mapper = nil
        sut = nil
        bag = nil
        super.tearDown()
    }

    func initializeSut(state: Observable<HeroState>) {
        sut = HeroDetailsDataBinder(
            state: state,
            mapper: mapper
        )
    }
}

// MARK: - Tests
extension HeroDetailsDataBinderTests {
    func testdetails() {
        // Given
        initializeSut(state: .just(HeroesModelFactory.mockState))
        Given(mapper, .mapDetails(from: .any, willReturn: mockHeroesComponentData))
        let givenName = "name"
        let giveDescription = "description"
        // When
        let data = sut.bind()

        // Then
        let name = data.heroDetailsComponentData.name.toBlocking(timeout: 10).first
        let description = data.heroDetailsComponentData.description.toBlocking(timeout: 10).first
        expect(name).to(equal(givenName))
        expect(description).to(equal(giveDescription))
    }
}

// MARK: - Mock data
extension HeroDetailsDataBinderTests {
    var mockHeroesComponentData: HeroDetailsComponent.Data {
        .init(
            image: .just(nil),
            name: .just("name"),
            description: .just("description"))
    }
}
