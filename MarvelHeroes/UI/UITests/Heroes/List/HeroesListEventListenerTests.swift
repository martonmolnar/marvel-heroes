//
//  HeroesListEventListenerTests.swift
//  UITests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Domain
import RxCocoa
import RxSwift
import SwiftyMocky

@testable import UI

final class HeroesListEventListenerTests: BaseTestCase {
    private var loadHeroesUseCase: LoadHeroesUseCaseInterfaceMock!
    private var dispatcher: DispatcherInterfaceMock!
    private var coordinator: HeroesListCoordinatorInterfaceMock!
    private var sut: HeroesListEventListener!
    private var bag: DisposeBag!

    override func setUp() {
        super.setUp()

        loadHeroesUseCase = LoadHeroesUseCaseInterfaceMock()
        dispatcher = DispatcherInterfaceMock()
        coordinator = HeroesListCoordinatorInterfaceMock()
        bag = DisposeBag()
    }

    override func tearDown() {
        dispatcher = nil
        coordinator = nil
        sut = nil
        bag = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension HeroesListEventListenerTests {
    func testViewWillAppear() {
        // Given
        let givenState = HeroesModelFactory.makeHeroesState()
        initSut(state: .just(givenState))

        let events = makeEvents(
            viewWillAppear: .just(())
        )

        // When
        sut.listen(events: events)

        // Then
        Verify(loadHeroesUseCase, 1, .execute(with: nil))
    }

    func testSelectedItem() {
        // Given
        var givenState = HeroesModelFactory.makeHeroesState()
        let givenHero = HeroesModelFactory.mockHero
        let givenHeroes = [ givenHero ]
        givenState.heroes = .success(givenHeroes)
        initSut(state: .just(givenState))

        let givenSelectedIndexPath = IndexPath(row: 0, section: 0)

        let events = makeEvents(
            selectedItem: .just(givenSelectedIndexPath)
        )

        // When
        sut.listen(events: events)

        // Then
        Verify(coordinator, 1, .didSelectHero(hero: .value(givenHero)))
    }

    func testSearchedText() {
        // Given
        var givenState = HeroesModelFactory.makeHeroesState()
        let givenHero = HeroesModelFactory.mockHero
        let givenHeroes = [ givenHero ]
        let givenText = "givenText".removingPercentEncoding
        givenState.heroes = .success(givenHeroes)
        initSut(state: .just(givenState))

        let events = makeEvents(
            textSearchEvents: SearchFieldComponent.Events(
                searchFieldDidBeginEditing: ControlEvent(events: Observable.never()),
                searchFieldDidEndEditing: ControlEvent(events: Observable.just(givenText)),
                searchFieldDidChange: ControlEvent(events: Observable.never())
        ))

        // When
        sut.listen(events: events)

        // Then
        Verify(loadHeroesUseCase, 1, .execute(with: Parameter(stringLiteral: givenText!)))
    }
}

// MARK: - Helpers
private extension HeroesListEventListenerTests {
    func initSut(state: Observable<HeroState>) {
        sut = HeroesListEventListener(
            state: state,
            loadHeroesUseCase: loadHeroesUseCase,
            coordinator: coordinator)
    }

    func makeEvents(textSearchEvents: SearchFieldComponent.Events = makeNoSearchEvents(),
                    viewWillAppear: Observable<Void> = .never(),
                    listRefresh: Observable<Void> = .never(),
                    selectedItem: Observable<IndexPath> = .never(),
                    cellEvents: TableViewComponent<HeroesCell>.CellEvents = makeNoCellEvents()) -> HeroesListEventListener.Events {

        let listEvents = TableViewComponent<HeroesCell>.Events(
            listRefresh: ControlEvent(events: listRefresh),
            selectedItem: ControlEvent(events: selectedItem)
        )
        return HeroesListEventListener.Events(
            textSearchEvents: textSearchEvents,
            viewWillAppear: ControlEvent(events: viewWillAppear),
            listEvents: listEvents,
            cellEvents: ControlEvent(events: Observable.just(cellEvents))
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
