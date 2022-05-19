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
    public var imageUri: URL?

    public init(id: Int, name: String, description: String, imageUri: URL?) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUri = imageUri
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)

        id = try container.decode("id")
        name = try container.decode("name")
        description = try container.decode("description")
        if let image = try container.decodeIfPresent(ImageModel.self, forKey: "thumbnail") {
            imageUri = URL(string: "\(image.path).\(image.imageExtension)".replacingOccurrences(of: "http:", with: "https:"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)

        try container.encode(id, forKey: "id")
        try container.encode(name, forKey: "name")
        try container.encode(description, forKey: "description")
    }
}


public struct ImageModel: APIModel {
    public let path: String
    public let imageExtension: String

    public init(path: String, imageExtension: String) {
        self.path = path
        self.imageExtension = imageExtension
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)

        path = try container.decode("path")
        imageExtension = try container.decode("extension")
    }
}
