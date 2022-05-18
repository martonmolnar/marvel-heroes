//
//  HeroListItemMapper.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import Domain

typealias HeroListItemMapper = AnyMapper<[HeroApiModel], [Hero]>

// sourcery: AutoMockable
// sourcery: typealias = "InputModel = HeroApiModel"
// sourcery: typealias = "OutputModel = Hero"
protocol HeroListItemMapperInterface: Mapper where InputModel == [HeroApiModel], OutputModel == [Hero] {}

final class DefaultHeroesListItemMapper: HeroListItemMapperInterface {
    func map(from apiModels: [HeroApiModel]) -> [Hero] {
        return apiModels.enumerated().map({ index, item in
            let hero = Hero(
                id: item.id,
                name: item.name,
                imageUri: item.imageUri?.absoluteString ?? "",
                description: item.description
            )
            return hero
        })
    }
}

