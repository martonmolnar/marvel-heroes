//
//  HeroesListEventListener.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import RxSwift
import RxCocoa
import Domain
import Common

final class HeroesListEventListener {
    // MARK: - Properties
    private let state: Observable<HeroState>
    private let loadHeroesUseCase: LoadHeroesUseCaseInterface
    private let coordinator: HeroesListCoordinatorInterface
    private let bag = DisposeBag()

    // MARK: - Init
    init(state: Observable<HeroState>,
         loadHeroesUseCase: LoadHeroesUseCaseInterface,
         coordinator: HeroesListCoordinatorInterface) {
        self.state = state.share(replay: 1)
        self.loadHeroesUseCase = loadHeroesUseCase
        self.coordinator = coordinator
    }
}

// MARK: - EventListener
extension HeroesListEventListener: EventListener {
    struct Events {
        let viewWillAppear: ControlEvent<Void>
        let listEvents: TableViewComponent<HeroesCell>.Events
        let cellEvents: ControlEvent<TableViewComponent<HeroesCell>.CellEvents>
    }

    func listen(events: Events) {

        events.viewWillAppear
            .bind(onNext: { [weak self] in
                self?.loadHeroesUseCase.execute()
            })
            .disposed(by: bag)

        events.listEvents.selectedItem
            .flatMap { [weak self] indexPath -> Observable<Hero?> in
                guard let self = self else { return .error(RxError.unknown) }
                return self.hero(at: indexPath)
            }
            .bind { [weak self] hero in
                guard let self = self,
                      let hero = hero else { return }
                self.coordinator.didSelectHero(id: hero.id)
            }
            .disposed(by: bag)
    }
}

// MARK: - Helpers
private extension HeroesListEventListener {
    func hero(at indexPath: IndexPath) -> Observable<Hero?> {
        return state
            .map { state -> Hero? in
                guard case .success(let heroes) = state.heroes, indexPath.row < heroes.count else { return nil }
                return heroes[indexPath.row]
            }
            .take(1)
    }
}


