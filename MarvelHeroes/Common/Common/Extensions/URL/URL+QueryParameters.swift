//
//  URL+QueryParameters.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

extension URL {
    public var queryParameters: QueryParameters { return QueryParameters(url: self) }
}

public typealias QueryParameterItem = (key: String, value: String?)

public class QueryParameters {
    public let queryItems: [URLQueryItem]

    public init(url: URL?) {
        queryItems = URLComponents(string: url?.absoluteString ?? "")?.queryItems ?? []
    }

    public init(params: [QueryParameterItem]) {
        queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
    }

    public subscript(name: String) -> String? {
        return queryItems.first(where: { $0.name == name })?.value
    }
}
