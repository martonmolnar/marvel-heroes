//
//  LoadHeroDetailsUseCaseInterface.swift
//  Domain
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import Common

// sourcery: AutoMockable
public protocol LoadHeroDetailsUseCaseInterface: UseCase {
    func execute(hero: Hero)
}
