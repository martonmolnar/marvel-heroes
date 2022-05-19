//
//  HeroDetailsEventListenerTests.swift
//  UITests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Domain
import RxCocoa
import RxSwift
import SwiftyMocky

@testable import UI

final class HeroDetailsEventListenerTests: BaseTestCase {
    private var loadHeroDetailsUseCase: LoadHeroDetailsUseCaseInterfaceMock!
    private var dispatcher: DispatcherInterfaceMock!
    private var sut: HeroDetailsEventListener!
    private var bag: DisposeBag!

    override func setUp() {
        super.setUp()

        loadHeroDetailsUseCase = LoadHeroDetailsUseCaseInterfaceMock()
        dispatcher = DispatcherInterfaceMock()
        bag = DisposeBag()
    }

    override func tearDown() {
        dispatcher = nil
        sut = nil
        bag = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension HeroDetailsEventListenerTests {
    func testViewWillAppear() {
        // Given
        let givenState = HeroesModelFactory.makeHeroesState()
        initSut(state: .just(givenState))
        let givenHero = HeroesModelFactory.mockHero
        let events = makeEvents(
            viewWillAppear: .just(())
        )
        sut.navigationParameter.accept(givenHero)
        // When
        sut.listen(events: events)

        // Then
        Verify(loadHeroDetailsUseCase, 1, .execute(hero: .value(givenHero)))
    }
}

// MARK: - Helpers
private extension HeroDetailsEventListenerTests {
    func initSut(state: Observable<HeroState>) {
        sut = HeroDetailsEventListener(
            state: state,
            loadHeroDetailsUseCase: loadHeroDetailsUseCase)
    }

    func makeEvents(viewWillAppear: Observable<Void> = .never()) -> HeroDetailsEventListener.Events {
        return HeroDetailsEventListener.Events(
            viewWillAppear: ControlEvent(events: viewWillAppear)
        )
    }

    static func makeNoCellEvents() -> TableViewComponent<HeroesCell>.CellEvents {
        return TableViewComponent<HeroesCell>.CellEvents(
            events: HeroesCell.Events(),
            indexPath: IndexPath(row: 0, section: 0),
            bag: DisposeBag()
        )
    }

    static func makeNoSearchEvents() -> SearchFieldComponent.Events {
        return SearchFieldComponent.Events(
            searchFieldDidBeginEditing: ControlEvent(events: Observable.never()),
            searchFieldDidEndEditing: ControlEvent(events: Observable.never()),
            searchFieldDidChange: ControlEvent(events: Observable.never()))
    }
}

