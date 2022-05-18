//
//  HeroDetailsEventListener.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import Common
import Domain
import RxCocoa
import RxSwift

final class HeroDetailsEventListener: RxParameterReceiver {
    // MARK: - Properties
    private let state: Observable<HeroState>
    private let loadHeroDetailsUseCase: LoadHeroDetailsUseCaseInterface
    private let bag = DisposeBag()
    let navigationParameter = BehaviorRelay<Hero?>(value: nil)

    // MARK: - Init
    init(state: Observable<HeroState>,
         loadHeroDetailsUseCase: LoadHeroDetailsUseCaseInterface) {
        self.state = state
        self.loadHeroDetailsUseCase = loadHeroDetailsUseCase
    }
}

// MARK: - EventListener
extension HeroDetailsEventListener: EventListener {
    struct Events {
        let viewWillAppear: ControlEvent<Void>
    }

    func listen(events: Events) {
        events.viewWillAppear
            .bind(onNext: { [weak self] in
                guard let hero = self?.navigationParameter.value else { return }
                self?.loadHeroDetails(hero)
            })
            .disposed(by: bag)
    }
}

// MARK: - Private
private extension HeroDetailsEventListener {
    func loadHeroDetails(_ hero: Hero) {
        loadHeroDetailsUseCase.execute(hero: hero)
    }
}

