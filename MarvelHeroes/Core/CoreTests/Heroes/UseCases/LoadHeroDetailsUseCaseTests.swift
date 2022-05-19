//
//  LoadHeroDetailsUseCaseTests.swift
//  CoreTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Common
import Domain
import Nimble
import SwiftyMocky

@testable import Core

final class LoadHeroDetailsUseCaseTests: BaseTestCase {
    private var dispatcher: DispatcherInterfaceMock!

    private var sut: LoadHeroDetailsUseCaseInterface!

    override func setUp() {
        super.setUp()
        dispatcher = DispatcherInterfaceMock()
        sut = LoadHeroDetailsUseCase(dispatcher: dispatcher)
    }

    override func tearDown() {
        dispatcher = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension LoadHeroDetailsUseCaseTests {
    func testWithSuccessfulResponse() {
        // Given
        let givenHero = HeroesModelFactory.makeHero()

        let heroeLoadedActionMatcher: (Action) -> Bool = { action in
            guard let action = action as? HeroesActions else { return false }
            return action == .didLoadHeroDetails(details: givenHero)
        }

        // When
        sut.execute(hero: givenHero)

        // Then
        Verify(dispatcher, 1, .dispatch(.matching(heroeLoadedActionMatcher)))
    }
}
