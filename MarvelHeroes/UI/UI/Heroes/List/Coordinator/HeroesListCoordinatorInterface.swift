//
//  HeroesListCoordinatorInterface.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import Domain

protocol HeroesListCoordinatorInterface: Coordinator, AutoMockable {
    func didSelectHero(hero: Hero)
}
