//
//  HeroesListApiModel.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public struct HeroesListApiModel: APIModel {

    public let heroes: [HeroApiModel]
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    enum ResultKeys: String, CodingKey {
      case results = "results"
    }

    public init(heroes: [HeroApiModel]) {
        self.heroes = heroes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: ResultKeys.self, forKey: .data)
        heroes = try data.decodeArray(.results)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)

        try container.encode(heroes, forKey: "results")
    }

}

