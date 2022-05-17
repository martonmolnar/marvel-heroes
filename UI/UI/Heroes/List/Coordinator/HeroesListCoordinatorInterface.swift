//
//  HeroesListCoordinatorInterface.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common

protocol HeroesListCoordinatorInterface: Coordinator {
    func didSelectHero(id: Int)
}
