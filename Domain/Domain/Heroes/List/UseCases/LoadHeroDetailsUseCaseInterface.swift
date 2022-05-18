//
//  LoadHeroDetailsUseCaseInterface.swift
//  Domain
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import Common

public protocol LoadHeroDetailsUseCaseInterface: UseCase {
    func execute(hero: Hero)
}
