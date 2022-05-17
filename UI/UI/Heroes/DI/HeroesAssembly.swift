//
//  HeroesAssembly.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Swinject
import Common
import Domain

// MARK: - Assemble
public final class HeroesAssembly: Assembly {
    public func assemble(container: Container) {
        registerCoordinator(to: container)
        registerScreens(to: container)
        registerEventListeners(to: container)
        registerDataBinders(to: container)
        registerMappers(to: container)
    }
}

// MARK: - Coordinator
private extension HeroesAssembly {
    func registerCoordinator(to container: Container) {
                container.register(HeroesListCoordinatorInterface.self) { resolver in
                    return HeroesListCoordinator(
                        navigator: resolver.get()
                    )
                }
                .inObjectScope(.weak)
    }
}

// MARK: - Screens
private extension HeroesAssembly {
    func registerScreens(to container: Container) {
        container.register(HeroesListScreen.self) { _ in
            HeroesListScreen()
        }
        .initCompleted { resolver, screen in
            screen.dataBinder = resolver.get()
            screen.eventListener = resolver.get()
        }
        .inObjectScope(.graph)
    }
}

// MARK: - EventListeners
private extension HeroesAssembly {
    func registerEventListeners(to container: Container) {
        container.register(HeroesListEventListener.self) { resolver in
            let store = resolver.resolve(AnyStore<HeroState>.self)!
            return HeroesListEventListener(
                state: store.getState(),
                loadHeroesUseCase: resolver.get(),
                coordinator: resolver.get())
        }
        .inObjectScope(.graph)
    }
}

// MARK: - DataBinders
private extension HeroesAssembly {
    func registerDataBinders(to container: Container) {
        container.register(HeroesListDataBinder.self) { resolver in
            let store = resolver.resolve(AnyStore<HeroState>.self)!
            return HeroesListDataBinder(
                state: store.getState(),
                mapper: resolver.get())
        }
        .inObjectScope(.graph)
    }
}

// MARK: - Mappers
private extension HeroesAssembly {
    func registerMappers(to container: Container) {
        container.register(HeroesListItemUIMapperInterface.self) { _ in
            DefaultHeroesListItemUIMapper()
        }
        .inObjectScope(.graph)
    }
}
