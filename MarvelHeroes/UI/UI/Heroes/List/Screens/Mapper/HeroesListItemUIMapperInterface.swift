//
//  HeroesListItemUIMapperInterface.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import Domain
import RxCocoa
import RxSwift
import UIKit

protocol HeroesListItemUIMapperInterface: AutoMockable {
    func map(from state: HeroState) -> [HeroesCell.Data]?
}

final class DefaultHeroesListItemUIMapper: HeroesListItemUIMapperInterface {

    func map(from state: HeroState) -> [HeroesCell.Data]? {
        guard case .success(let heroes) = state.heroes else { return nil }
        return heroes.compactMap { [weak self] in
            self?.listItem(from: $0)
        }
    }
}

// MARK: - Private
private extension DefaultHeroesListItemUIMapper {
    enum Constants {
    }

    func listItem(from hero: Hero) -> HeroesCell.Data {
        return HeroesCell.Data(
            image: image(from: hero),
            title: title(from: hero))
    }

    func image(from hero: Hero) -> Driver<UIImage?> {
        return Observable.just(hero.imageUri)
            .flatMap { ImageDownloader.download(from: $0) }
            .startWith(UIImage(named: "image_not_available"))
            .asDriver(onErrorJustReturn: UIImage(named: "image_not_available"))
    }

    func title(from hero: Hero) -> String {
        return hero.name
    }

}

