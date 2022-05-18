//
//  HeroesUseCaseFactory.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 16..
//

import Common
import Domain
import Swinject

enum HeroesUseCaseFactory {
    static func makeLoadHeroesUseCase(with resolver: Resolver) -> LoadHeroesUseCaseInterface {
        let dispatcher = resolver.resolve(DispatcherInterface.self)!
        return LoadHeroesUseCase(
            service: resolver.get(),
            listItemMapper: resolver.get(),
            dispatcher: dispatcher)
    }

    static func makeLoadHeroDetailsUseCase(with resolver: Resolver) -> LoadHeroDetailsUseCaseInterface {
        let dispatcher = resolver.resolve(DispatcherInterface.self)!
        return LoadHeroDetailsUseCase(
            dispatcher: dispatcher)
    }
}
