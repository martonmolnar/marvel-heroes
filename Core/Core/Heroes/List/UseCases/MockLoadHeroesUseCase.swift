//
//  MockLoadHeroesUseCase.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 17..
//

import Common
import Domain
import RxSwift

final class MockLoadHeroesUseCase {
    // MARK: - Properties
    private let dispatcher: DispatcherInterface
    private let bag = DisposeBag()

    // MARK: - Init
    init(dispatcher: DispatcherInterface) {
        self.dispatcher = dispatcher
    }
}

// MARK: - LoadHeroesUseCaseInterface
extension MockLoadHeroesUseCase: LoadHeroesUseCaseInterface {
    func execute() {
        let heroes = HeroesModelFactory.mockHeroes
        let action: HeroesActions = .didLoadHeroes(heroes: heroes)
        dispatcher.dispatch(action)
    }
}

