//
//  CommonAssembly.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 16..
//

import Domain
import Swinject
import Common

public final class CommonAssembly: Assembly {
    public init() { /* no-op */ }
    public func assemble(container: Container) {
        registerSchedulerProvider(to: container)
        registerServerAddressProvider(to: container)
        registerDispatcher(to: container)
        registerAPIClient(to: container)
    }
}

extension CommonAssembly {
    // MARK: - Register
    private func registerSchedulerProvider(to container: Container) {
        container.register(SchedulerProviderInterface.self) { _ in
            return SchedulerProvider()
        }
        .inObjectScope(.graph)
    }

    private func registerDispatcher(to container: Container) {
        container.register(DispatcherInterface.self) { _ in
            return Dispatcher()
        }
        .inObjectScope(.container)
    }

    private func registerAPIClient(to container: Container) {
        container.register(ApiClientServiceInterface.self) { resolver in
            /// DI Components
            let serverAddressProvider = resolver.resolve(ServerAddressProviderInterface.self)!

            return DefaultApiClientService(
                baseURL: serverAddressProvider.gatewayUrl())
        }
        .inObjectScope(.container)
    }

    private func registerServerAddressProvider(to container: Container) {
        container.register(ServerAddressProviderInterface.self) { resolver in
            return DefaultServerAddressProvider(userDefaults: UserDefaults.standard)
        }
        .inObjectScope(.container)
    }
}
