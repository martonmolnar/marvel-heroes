//
//  AppContainer.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Swinject

public final class AppContainer {
    public static let shared = AppContainer()
    private init() {
        // no-op
    }

    public unowned var container: Container!
}
