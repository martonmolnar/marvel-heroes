//
//  HeroDetails.swift
//  Domain
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public struct HeroDetails: Equatable {
    public private(set) var hero: Hero
    public let description: String

    public init(hero: Hero,
                description: String) {
        self.hero = hero
        self.description = description
    }

    public mutating func update(hero: Hero) {
        self.hero = hero
    }
}
