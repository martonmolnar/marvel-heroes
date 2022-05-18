//
//  HeroDetailsDataBinder.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import Common
import Domain
import RxSwift
import RxCocoa

final class HeroDetailsDataBinder {

    // MARK: - Properties
    private let state: Observable<HeroState>
    private let mapper: HeroDetailsUIMapperInterface
    private let bag = DisposeBag()

    // MARK: - Init
    init(state: Observable<HeroState>,
         mapper: HeroDetailsUIMapperInterface) {
        self.state = state
        self.mapper = mapper
    }
}

// MARK: - DataBinder
extension HeroDetailsDataBinder: DataBinder {
    struct Data {
        let heroDetailsComponentData: HeroDetailsComponent.Data
    }

    func bind() -> Data {

        let heroDetails = state.mapAt(\.heroDetails).share().unwrap()

        return Data(
            heroDetailsComponentData: heroDetailsComponent(heroDetails: heroDetails)
        )
    }
}

// MARK: - Mappers
private extension HeroDetailsDataBinder {

    func heroDetailsComponent(heroDetails: Observable<Hero>) -> HeroDetailsComponent.Data {
        return mapper.mapDetails(from: heroDetails)
    }
}

