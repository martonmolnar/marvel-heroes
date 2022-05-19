//
//  HeroesAssembly.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Swinject
import Common
import Domain

final class HeroesAssembly: Assembly {
    func assemble(container: Container) {
        registerStore(to: container)
        registerService(to: container)
        registerUseCases(to: container)
        registerMapper(to: container)
    }
}

// MARK: - Store
private extension HeroesAssembly {
    func registerStore(to container: Container) {
        container.register(AnyStore<HeroState>.self) { resolver in
            AnyStore(wrappedStore: HeroesStore(
                state: HeroesModelFactory.makeHeroesState(),
                schedulerProvider: resolver.get()))
        }
        .initCompleted { resolver, store in
            let dispatcher = resolver.resolve(DispatcherInterface.self)!
            let token = dispatcher.register(store: store)

            store.setDispatchToken(token, onDeinit: {
                dispatcher.unregister(token: token)
            })
        }
        .inObjectScope(.session)
    }
}

// MARK: - Service
private extension HeroesAssembly {
    func registerService(to container: Container) {
        container.register(HeroServiceInterface.self) { resolver in
            let apiClient = resolver.resolve(ApiClientServiceInterface.self)!

            return DefaultHeroService(apiClient: apiClient)
        }
        .inObjectScope(.graph)
    }
}

// MARK: - Use cases
private extension HeroesAssembly {
    func registerUseCases(to container: Container) {

        container.register(LoadHeroesUseCaseInterface.self) { resolver in
            HeroesUseCaseFactory.makeLoadHeroesUseCase(with: resolver)
        }
        .inObjectScope(.transient)

        container.register(LoadHeroDetailsUseCaseInterface.self) { resolver in
            HeroesUseCaseFactory.makeLoadHeroDetailsUseCase(with: resolver)
        }
        .inObjectScope(.transient)
    }
}

// MARK: - Mapper
private extension HeroesAssembly {
    func registerMapper(to container: Container) {
        container.register(HeroListItemMapper.self) { _ in
            let wrappedMapper = DefaultHeroesListItemMapper()
            return HeroListItemMapper(wrappedMapper: wrappedMapper)
        }
        .inObjectScope(.graph)
    }
}

