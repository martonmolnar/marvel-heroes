//
//  HeroesAssembly.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Swinject

// MARK: - Assemble
public final class HeroesAssembly: Assembly {
    public func assemble(container: Container) {
        registerScreens(to: container)
    }
}

// MARK: - Screens
private extension HeroesAssembly {
    func registerScreens(to container: Container) {
        container.register(HeroesListScreen.self) { _ in
            HeroesListScreen()
        }
        .initCompleted { resolver, screen in
//            screen.dataBinder = resolver.get()
//            screen.eventListener = resolver.get()
        }
        .inObjectScope(.graph)
    }
}
