//
//  LoadHeroesUseCase.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import RxSwift
import Domain

final class LoadHeroesUseCase {
    // MARK: - Properties
    private let service: HeroServiceInterface
    private let listItemMapper: HeroListItemMapper
    private let dispatcher: DispatcherInterface
    private let bag = DisposeBag()

    // MARK: - Init
    init(service: HeroServiceInterface,
         listItemMapper: HeroListItemMapper,
         dispatcher: DispatcherInterface) {
        self.service = service
        self.listItemMapper = listItemMapper
        self.dispatcher = dispatcher
    }
}

// MARK: - LoadHeroesUseCaseInterface
extension LoadHeroesUseCase: LoadHeroesUseCaseInterface {
    func execute() {

        service.getHeroes()
            .do(onSubscribe: { [weak self] in
                self?.dispatchLoadHeroes()
            })
            .subscribe { [weak self, listItemMapper] response in
                switch response.respResult {
                case .success(let apiModel):
                    let heroes = listItemMapper.map(from: apiModel.heroes)
                    self?.dispatchHeroesLoaded(
                        heroes: heroes
                    )
                case .failure:
                    break
                }
            } onFailure: { _ in
            }
            .disposed(by: bag)
    }
}

// MARK: - Dispatch actions
private extension LoadHeroesUseCase {
    func dispatchLoadHeroes() {
        let action: HeroesActions = .didStartLoadingHeroes
        dispatcher.dispatch(action)
    }

    func dispatchHeroesLoaded(heroes: [Hero]) {
        let action: HeroesActions = .didLoadHeroes(heroes: heroes)
        dispatcher.dispatch(action)
    }
}
