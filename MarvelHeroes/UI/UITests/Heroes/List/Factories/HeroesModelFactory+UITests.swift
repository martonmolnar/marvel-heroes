//
//  HeroesModelFactory+UITests.swift
//  UITests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Domain

// MARK: - Mock objects for UI
extension HeroesModelFactory {
    static var mockState: HeroState {
        let mockHero = Hero(
            id: 1,
            name: "name",
            imageUri: "imageUri",
            description: "description")
        return HeroState(
            heroes: .success([mockHero]),
            isLoading: false,
            heroDetails: nil,
            heroDetailsError: [],
            isDetailLoading: false)
    }

    static var mockHero: Hero {
        Hero(
            id: 1,
            name: "name",
            imageUri: "imageUri",
            description: "description")
    }
}
