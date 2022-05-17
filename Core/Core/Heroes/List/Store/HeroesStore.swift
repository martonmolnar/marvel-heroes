//
//  HeroesStore.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import Domain

final class HeroesStore: BaseStore<HeroState>, HeroesStoreInterface {
    override func reduce() -> Reducer {
        return { [ weak self ] action in
            guard let self = self else { return }
            guard let action = action as? HeroesActions else { return }

            switch action {
            case .didStartLoadingHeroes:
                self.startLoading()
            case .didLoadHeroes(let heroes):
                self.update(heroes: heroes)
            }
        }
    }
}

// MARK: - Update state
private extension HeroesStore {
    func startLoading() {
        modify { state in
            state.isLoading = true
        }
    }

    func update(heroes: [Hero]) {
        modify { state in
            state.isLoading = false
            state.heroes = .success(heroes)
        }
    }
}

