//
//  LoadHeroDetailsUseCase.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import Common
import Domain
import RxSwift

final class LoadHeroDetailsUseCase {
    // MARK: - Properties
    private let dispatcher: DispatcherInterface
    private let bag = DisposeBag()

    // MARK: - Init
    init(dispatcher: DispatcherInterface) {
        self.dispatcher = dispatcher
    }
}

// MARK: - LoadHeroDetailsUseCaseUseCaseInterface
extension LoadHeroDetailsUseCase: LoadHeroDetailsUseCaseInterface {
    func execute(hero: Hero) {
        dispatchHeroDetailsLoaded(details: hero)
    }
}

// MARK: - Dispatch actions
private extension LoadHeroDetailsUseCase {
    func dispatchHeroDetailsLoaded(details: Hero) {
        let action: HeroesActions = .didLoadHeroDetails(details: details)
        dispatcher.dispatch(action)
    }
}

