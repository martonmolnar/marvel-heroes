//
//  HeroesStoreTests.swift
//  CoreTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Common
import Domain
import RxSwift
import RxTest
import Swinject
import SwiftyMocky
import XCTest

@testable import Core

final class HeroesStoreTests: BaseTestCase {
    var scheduler: TestScheduler!
    var schedulerProvider: SchedulerProviderInterfaceMock!

    var sut: HeroesStore!
    var bag: DisposeBag!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        schedulerProvider = SchedulerProviderInterfaceMock()
        sut = HeroesStore(state: HeroesModelFactory.makeHeroesState(),
                            schedulerProvider: schedulerProvider)
        bag = DisposeBag()
    }

    override func tearDown() {
        scheduler = nil
        sut = nil
        bag = nil
        super.tearDown()
    }
}

// MARK: Tests
extension HeroesStoreTests {
    func testLoadHeroes() {
        // Given
        let listener = scheduler.createObserver(Bool.self)
        let action = HeroesActions.didStartLoadingHeroes
        Given(schedulerProvider, .mainScheduler(getter: scheduler))
        sut.getState()
            .map { $0.isLoading }
            .bind(to: listener)
            .disposed(by: bag)

        // When
        sut.reduce()(action)
        scheduler.start()
        // Then
        XCTAssertEqual(listener.events, [
            .next(1, false),
            .next(2, true)
        ])
        Verify(schedulerProvider, 1, .mainScheduler)
    }

    func testHeroesLoaded() {
        // Given
        let loadingListener = scheduler.createObserver(Bool.self)
        let heroesListener = scheduler.createObserver(Swift.Result<[Hero], HeroError>?.self)

        let givenHeroes = [ HeroesModelFactory.makeHero() ]
        let action = HeroesActions.didLoadHeroes(heroes: givenHeroes)
        Given(schedulerProvider, .mainScheduler(getter: scheduler))
        sut.getState()
            .skip(1)
            .map { $0.isLoading }
            .bind(to: loadingListener)
            .disposed(by: bag)

        sut.getState()
            .map { $0.heroes }
            .bind(to: heroesListener)
            .disposed(by: bag)

        // When
        sut.reduce()(action)
        scheduler.start()
        // Then
        XCTAssertEqual(loadingListener.events, [
            .next(2, false)
        ])

        XCTAssertEqual(heroesListener.events, [
            .next(1, nil),
            .next(2, .success(givenHeroes))
        ])

        Verify(schedulerProvider, 2, .mainScheduler)
    }

    func testHeroesDetailsLoaded() {
        // Given
        let loadingListener = scheduler.createObserver(Bool.self)
        let detailsListener = scheduler.createObserver(Hero?.self)

        let givenDetails = HeroesModelFactory.makeHero()
        let action = HeroesActions.didLoadHeroDetails(details: givenDetails)
        Given(schedulerProvider, .mainScheduler(getter: scheduler))
        sut.getState()
            .skip(1)
            .map { $0.isDetailLoading }
            .bind(to: loadingListener)
            .disposed(by: bag)

        sut.getState()
            .skip(1)
            .map { $0.heroDetails }
            .bind(to: detailsListener)
            .disposed(by: bag)

        // When
        sut.reduce()(action)
        scheduler.start()
        // Then
        XCTAssertEqual(loadingListener.events, [
            .next(2, false)
        ])

        XCTAssertEqual(detailsListener.events, [
            .next(2, givenDetails)
        ])

        Verify(schedulerProvider, 2, .mainScheduler)
    }
}
