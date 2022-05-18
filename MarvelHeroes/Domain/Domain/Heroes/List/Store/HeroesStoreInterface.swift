//
//  HeroesStoreInterface.swift
//  Domain
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import Common

// sourcery: AutoMockable
// sourcery: typealias = "BoundedContext = HeroState"
public protocol HeroesStoreInterface: Store where BoundedContext == HeroState {}
