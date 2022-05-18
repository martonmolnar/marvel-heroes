//
//  LoadHeroesUseCaseInterface.swift
//  Domain
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common

public protocol LoadHeroesUseCaseInterface: UseCase {
    func execute(with searchText: String?)
}
