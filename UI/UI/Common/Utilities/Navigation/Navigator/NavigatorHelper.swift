//
//  NavigatorHelper.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit
import Common

public final class NavigatorHelper {
    private var navigator: NavigatorType!

    public init(window: UIWindow) {
        self.navigator = ScreenNavigator(window: window)
        AppContainer.shared.container.register(NavigatorType.self) { _ in self.navigator }.inObjectScope(.container)
    }

    public func navigateToHeroesListScreen() {
        navigator.transition(to: HeroesListScreen.self, transition: .root)
    }
}
