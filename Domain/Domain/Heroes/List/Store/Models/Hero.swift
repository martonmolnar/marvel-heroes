//
//  Hero.swift
//  Domain
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public struct Hero: Equatable {
    public let id: Int
    public let name: String
    public let description: String

    public init(id: Int,
                name: String,
                description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
