//
//  HeroesModelFactory+CoreTests.swift
//  CoreTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Foundation
import Domain
import Core

extension HeroesModelFactory {
    static func makeHeroesResponseApiModel() -> HeroesListApiModel {
        .init(
            heroes: [ makeHeroApiModel() ]
        )
    }

    static func makeHeroApiModel() -> HeroApiModel {
        .init(
            id: 1234,
            name: "5% kezdvezmény vásárlásokból",
            description: "MintaBolt Kft.",
            imageUri: URL(string: "http://test.com/imageUri")!
        )
    }

    static func makeHero() -> Hero {
        return Hero(
            id: 1234,
            name: "name",
            imageUri: "imageUri",
            description: "description")
    }
}
