//
//  LoadHeroesUseCaseTests.swift
//  CoreTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Common
import Domain
import Nimble
import SwiftyMocky

@testable import Core

final class LoadHeroesUseCaseTests: BaseTestCase {
    private var service: HeroServiceInterfaceMock!
    private var dispatcher: DispatcherInterfaceMock!
    private var itemMapper: HeroListItemMapperInterfaceMock!

    private var sut: LoadHeroesUseCaseInterface!

    override func setUp() {
        super.setUp()
        service = HeroServiceInterfaceMock()
        dispatcher = DispatcherInterfaceMock()
        itemMapper = HeroListItemMapperInterfaceMock()
        sut = LoadHeroesUseCase(
            service: service,
            listItemMapper: HeroListItemMapper(wrappedMapper: itemMapper),
            dispatcher: dispatcher
        )
    }

    override func tearDown() {
        service = nil
        dispatcher = nil
        itemMapper = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension LoadHeroesUseCaseTests {
    func testWithSuccessfulResponse() {
        // Given
        let givenHeroes = [ HeroesModelFactory.makeHero() ]
        let givenApiModel = HeroesModelFactory.makeHeroesResponseApiModel()
        let givenResponse =  Heroes.Hero.GetHeroesList.Response.status200(givenApiModel)

        Given(service, .getHeroes(searchText: nil, willReturn: .just(givenResponse)))
        Given(itemMapper, .map(from: .value(givenApiModel.heroes), willReturn: givenHeroes))

        let loadHeroesActionMatcher: (Action) -> Bool = { action in
            guard let action = action as? HeroesActions else { return false }
            return action == .didStartLoadingHeroes
        }

        let heroesLoadedActionMatcher: (Action) -> Bool = { action in
            guard let action = action as? HeroesActions else { return false }
            return action == .didLoadHeroes(heroes: givenHeroes)
        }

        // When
        sut.execute(with: nil)

        // Then
        Verify(service, 1, .getHeroes(searchText: nil))
        Verify(itemMapper, 1, .map(from: .value(givenApiModel.heroes)))
        Verify(dispatcher, 1, .dispatch(.matching(loadHeroesActionMatcher)))
        Verify(dispatcher, 1, .dispatch(.matching(heroesLoadedActionMatcher)))
    }
}
