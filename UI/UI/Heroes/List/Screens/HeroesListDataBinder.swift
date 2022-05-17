//
//  HeroesListDataBinder.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import Domain
import RxSwiftExt
import RxSwift
import RxCocoa

final class HeroesListDataBinder {
    // MARK: - Properties
    private let state: Observable<HeroState>
    private let mapper: HeroesListItemUIMapperInterface

    // MARK: - Init
    init(state: Observable<HeroState>,
         mapper: HeroesListItemUIMapperInterface) {
        self.state = state.share(replay: 1)
        self.mapper = mapper
    }
}

// MARK: - DataBinder
extension HeroesListDataBinder: DataBinder {
    struct Data {
        let title: String
        let listData: TableViewComponent<HeroesCell>.Data
        let isLoading: Driver<Bool>
    }

    func bind() -> Data {
        let isLoading = state.map { $0.isLoading }.asDriver(onErrorJustReturn: false)
        return Data(
            title: Constants.title,
            listData: listData(),
            isLoading: isLoading)
    }
}

// MARK: - Setup
private extension HeroesListDataBinder {
    func listData() -> TableViewComponent<HeroesCell>.Data {
        let items = state
            .map { [mapper] in mapper.map(from: $0) }.unwrap()

        return TableViewComponent<HeroesCell>.Data(
            items: items.asDriver(onErrorJustReturn: []),
            loading: .just(false),
            errorOccurred: .just(false)
        )
    }
}

// MARK: - Constants
private extension HeroesListDataBinder {
    enum Constants {
        static let title = "Heroes"
    }
}
