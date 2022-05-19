//
//  HeroesListCoordinatorTests.swift
//  UITests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Common
import Domain
import Foundation
import Nimble
import XCTest
import SwiftyMocky
import RxSwift
import RxTest

@testable import UI

final class HeroesListCoordinatorTests: BaseTestCase {
    private var navigator: NavigatorTypeMock!

    private var sut: HeroesListCoordinatorInterface!

    override func setUp() {
        super.setUp()
        navigator = NavigatorTypeMock()
        sut = HeroesListCoordinator(navigator: navigator)
    }

    override func tearDown() {
        navigator = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension HeroesListCoordinatorTests {

    func testDidSelectHero() {
        // Given
        let givenHero = Hero(id: 1, name: "name", imageUri: "imageUri", description: "description")
        Matcher.default.register(HeroDetailsScreen.Type.self) { $0 == $1 }

        let navigationParameterMatcher: (NavigationParameter?) -> Bool = { parameter in
            guard case .heroDetails(let hero) = parameter else { return false }

            return hero == givenHero
        }

        // When
        sut.didSelectHero(hero: givenHero)

        // Then
        Verify(navigator, .transition(to: .value(HeroDetailsScreen.self),
                                      transition: .value(.push),
                                      with: .matching(navigationParameterMatcher)))
    }
}
