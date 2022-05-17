//
//  HeroesStoreInterface.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Domain
import Common

public protocol HeroesStoreInterface: Store where BoundedContext == HeroState {}
