//
//  HeroesModelFactory.swift
//  Domain
//
//  Created by Molnar Marton on 2022. 05. 16..
//

public enum HeroesModelFactory {
    public static func makeHeroesState() -> HeroState {
        
        return HeroState(
            heroes: nil,
            isLoading: false,
            heroDetails: nil,
            heroDetailsError: [],
            isDetailLoading: false)
    }
}

