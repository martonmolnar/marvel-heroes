//
//  DefaultServerAddressProvider.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 16..
//

import Common
import Domain

public final class DefaultServerAddressProvider {
    private enum Constants {
        static let configurationError = "Configuration missing"
        static let gateway = "https://gateway.marvel.com"
    }

    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}

extension DefaultServerAddressProvider: ServerAddressProviderInterface {
    public func gatewayUrl() -> String {
        return Constants.gateway
    }
}

