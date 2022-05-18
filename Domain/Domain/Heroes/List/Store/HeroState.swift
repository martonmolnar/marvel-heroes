//
//  HeroState.swift
//  Domain
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common

public struct HeroState {
    public var heroes: Swift.Result<[Hero], HeroError>?
    public var isLoading: Bool

    public var heroDetails: Hero?
    public var heroDetailsError: Set<HeroDetailsError>
    public var isDetailLoading: Bool

    public init(heroes: Swift.Result<[Hero], HeroError>?,
                isLoading: Bool,
                heroDetails: Hero?,
                heroDetailsError: Set<HeroDetailsError>,
                isDetailLoading: Bool) {
        self.heroes = heroes
        self.isLoading = isLoading
        self.heroDetails = heroDetails
        self.heroDetailsError = heroDetailsError
        self.isDetailLoading = isDetailLoading
    }
}

// MARK: - State
extension HeroState: State {
    public static func == (lhs: HeroState, rhs: HeroState) -> Bool {
        return lhs.heroes == rhs.heroes &&
            lhs.isLoading == rhs.isLoading &&
            lhs.heroDetails == rhs.heroDetails &&
            lhs.heroDetailsError == rhs.heroDetailsError &&
            lhs.isDetailLoading == rhs.isDetailLoading
    }
}


