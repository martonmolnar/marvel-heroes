//
//  HeroesModelFactory+Core.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 17..
//

import Domain


extension HeroesModelFactory {
    static var mockHeroes: [Hero] {
        return [
            mockHero(),
            mockHero()
        ]
    }

    static func mockHero() -> Hero {
        return Hero(id: 1, name: "TestHero", description: "TestDescription")
    }
}
