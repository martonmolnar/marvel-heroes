//
//  HeroApiModel.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public struct HeroApiModel: APIModel {
    public let id: Int
    public let name: String
    public let description: String

    public init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)

        id = try container.decode("id")
        name = try container.decode("name")
        description = try container.decode("description")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)

        try container.encode(id, forKey: "id")
        try container.encode(name, forKey: "name")
        try container.encode(description, forKey: "description")
    }
}
