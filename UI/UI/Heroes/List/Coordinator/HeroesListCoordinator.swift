//
//  HeroesListCoordinator.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 16..
//

import Common
import RxSwift

final class HeroesListCoordinator {
    // MARK: - Properties
    let navigator: NavigatorType

    private let bag = DisposeBag()

    // MARK: - Init
    init(navigator: NavigatorType) {
        self.navigator = navigator
    }
}

// MARK: - HeroesListCoordinatorInterface
extension HeroesListCoordinator: HeroesListCoordinatorInterface {
    func start(payload: QueryParameters?) {
    }

    func didSelectHero(id: Int) {
    }
}

