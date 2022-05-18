//
//  HeroDetailsMapper.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import Common
import Domain
import RxCocoa
import RxSwift
import UIKit

protocol HeroDetailsUIMapperInterface {
    func mapDetails(from hero: Observable<Hero>) -> HeroDetailsComponent.Data
}

final class HeroDetailsUIMapper: HeroDetailsUIMapperInterface {
    func mapDetails(from hero: Observable<Hero>) -> HeroDetailsComponent.Data {
        return .init(
            image: image(from: hero),
            name: hero.map({ $0.name}).asDriver(onErrorJustReturn: ""),
            description: hero.map({ $0.description}).asDriver(onErrorJustReturn: "")
        )
    }
}

// MARK: - Submappers
private extension HeroDetailsUIMapper {
    func image(from hero: Observable<Hero>) -> Driver<UIImage?> {
        return hero
            .flatMap { ImageDownloader.download(from: $0.imageUri) }
            .startWith(UIImage(named: "image_not_available"))
            .asDriver(onErrorJustReturn: UIImage(named: "image_not_available"))
    }
}


