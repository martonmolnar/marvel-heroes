//
//  NavigatorType.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit
import Common

public typealias ParameterReceiverController = (controller: UIViewController, parameter: NavigationParameter?)

public protocol NavigatorType: AnyObject {
    var navigationController: UINavigationController? { get }

    var currentViewController: UIViewController? { get }

    var isCurrentViewControllerInModal: Bool { get }

    func setCurrentViewController(viewController: UIViewController)

    func transition<T: UIViewController>(to type: T.Type, transition: ScreenTransitionType, animated: Bool)

    func transition<T: UIViewController>(to type: T.Type,
                                         name: String?,
                                         transition: ScreenTransitionType,
                                         animated: Bool)

    func transition<T: Parameterizable>(to type: T.Type, transition: ScreenTransitionType)

    func transition<T: Parameterizable>(to type: T.Type, transition: ScreenTransitionType, animated: Bool, with parameter: NavigationParameter?)

    func transition<T: Parameterizable>(to type: T.Type,
                                        transition: ScreenTransitionType,
                                        with parameter: NavigationParameter?)

    func transition<T: Parameterizable>(to type: T.Type,
                                        name: String?,
                                        transition: ScreenTransitionType,
                                        with parameter: NavigationParameter?)

    func transition<T: Parameterizable>(to type: T.Type,
                                        argument: String,
                                        transition: ScreenTransitionType,
                                        with parameter: NavigationParameter?)

    func pop<T: Parameterizable>(to type: T.Type, animated: Bool, with parameter: NavigationParameter?)

    func dismiss(animated: Bool, completion: (() -> Void)?)

    func dismissAndPush<T: Parameterizable>(type: T.Type, animated: Bool, with parameter: NavigationParameter?)

    func dismissAndPresent<T: Parameterizable>(type: T.Type, animated: Bool, with parameter: NavigationParameter?)

    func dissmissAndPop(animated: Bool, with parameter: NavigationParameter?)

    func pop(animated: Bool, with parameter: NavigationParameter?)

    func setCurrentNavigationController(_ navigationController: UINavigationController)

    func navigateToUrl(_ url: URL)
}

extension NavigatorType {
    func pop(animated: Bool = true) {
        return pop(animated: animated, with: nil)
    }

    public func transition<T: UIViewController>(to type: T.Type,
                                                transition: ScreenTransitionType) {
        self.transition(to: type, transition: transition, animated: true)
    }
}

