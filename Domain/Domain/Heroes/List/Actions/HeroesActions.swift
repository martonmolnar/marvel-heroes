//
//  HeroesActions.swift
//  Domain
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common

public enum HeroesActions: Action, Equatable {
    case didStartLoadingHeroes
    case didLoadHeroes(heroes: [Hero])
    case didLoadHeroDetails(details: Hero)
}
