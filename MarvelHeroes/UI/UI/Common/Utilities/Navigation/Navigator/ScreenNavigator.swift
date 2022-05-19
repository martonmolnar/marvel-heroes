//
//  ScreenNavigator.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit
import Common

// MARK: - NavigatorType
final class ScreenNavigator: NavigatorType {
    private let window: UIWindow
    private var currentNavigationController: UINavigationController?

    var navigationController: UINavigationController? {
        return currentNavigationController ?? window.rootViewController as? UINavigationController
    }

    var currentViewController: UIViewController? {
        return navigationController?.topViewController
    }

    var isCurrentViewControllerInModal: Bool {
        return currentViewController?.presentedViewController != nil
    }

    required init(window: UIWindow) {
        self.window = window
    }

    func setCurrentViewController(viewController: UIViewController) {
        navigationController?.setViewControllers([viewController], animated: false)
    }

    func transition<T: UIViewController>(to type: T.Type, transition: ScreenTransitionType, animated: Bool) {

        let viewController = AppContainer.shared.container.resolve(type)!

        if transition == .push, currentViewController == viewController {
            pop(animated: false)
        }

        self.transition(to: viewController, transition: transition, animated: animated)
    }

    func transition<T: UIViewController>(to type: T.Type,
                                         name: String?,
                                         transition: ScreenTransitionType,
                                         animated: Bool) {

        let viewController = AppContainer.shared.container.resolve(type, name: name)!

        if transition == .push, currentViewController == viewController {
            pop(animated: false)
        }

        self.transition(to: viewController, transition: transition, animated: animated)
    }

    func transition<T: Parameterizable>(to type: T.Type,
                                        transition: ScreenTransitionType,
                                        with parameter: NavigationParameter?) {
        self.transition(to: type,
                        name: nil,
                        transition: transition,
                        with: parameter)
    }

    func transition<T: Parameterizable>(to type: T.Type,
                                        name: String?,
                                        transition: ScreenTransitionType,
                                        with parameter: NavigationParameter?) {

        let viewController = AppContainer.shared.container.resolve(type, name: name)!
        setParameter(to: viewController, parameter: parameter)

        if transition == .push, currentViewController?.presentedViewController != nil {
            dismissAndPush(type: type, animated: true, with: parameter)
            return
        } else if transition == .push, currentViewController == viewController {
            pop(animated: false)
        }

        self.transition(to: viewController, transition: transition)
    }

    func transition<T: Parameterizable>(to type: T.Type,
                                        argument: String,
                                        transition: ScreenTransitionType,
                                        with parameter: NavigationParameter?) {

        let viewController = AppContainer.shared.container.resolve(type, argument: argument)!
        setParameter(to: viewController, parameter: parameter)

        if transition == .push, currentViewController?.presentedViewController != nil {
            dismissAndPush(type: type, animated: true, with: parameter)
            return
        } else if transition == .push, currentViewController == viewController {
            pop(animated: false)
        }

        self.transition(to: viewController, transition: transition)
    }

    func transition<T: Parameterizable>(to type: T.Type, transition: ScreenTransitionType) {
        let viewController = AppContainer.shared.container.resolve(type)!
        self.transition(to: viewController, transition: transition)
    }

    func transition<T: Parameterizable>(to type: T.Type, transition: ScreenTransitionType, animated: Bool = true, with parameter: NavigationParameter? = nil) {

        let viewController = AppContainer.shared.container.resolve(type)!
        if let parameter = parameter {
            setParameter(to: viewController, parameter: parameter)
        }
        self.transition(to: viewController, transition: transition, animated: animated)
    }

    private func transition(to viewController: UIViewController,
                            transition: ScreenTransitionType,
                            animated: Bool = true) {
        switch transition {
        case .root:
            rootViewController(viewController: viewController)
        case .push:
            pushViewController(viewController: viewController, animated: animated)
        case .modal:
            modalViewController(viewController: viewController)
        }
    }

    func pop(animated: Bool, with parameter: NavigationParameter? = nil) {
        if currentViewController?.presentedViewController != nil {
            topPresentedViewController?.dismiss(animated: animated)
        } else if let navigationController = navigationController {
            navigationController.popViewController(animated: animated)
        }
    }

    func pop<T: Parameterizable>(to type: T.Type, animated: Bool, with parameter: NavigationParameter? = nil) {
        if currentViewController?.presentedViewController != nil {
            topPresentedViewController?.dismiss(animated: animated)
        }

        guard let navigationController = currentViewController?.navigationController else { return }
        if let viewController = navigationController.viewControllers.last(where: { $0 is T }) as? T {
            navigationController.popToViewController(viewController, animated: animated)
            setParameter(to: viewController, parameter: parameter)
        } else if let viewController = navigationController.parent as? T {
            setParameter(to: viewController, parameter: parameter)
        }
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        currentViewController?.dismiss(animated: true, completion: completion)
    }

    func dismissAndPush<T: Parameterizable>(type: T.Type, animated: Bool, with parameter: NavigationParameter? = nil) {

        let viewController = AppContainer.shared.container.resolve(type)!
        if currentViewController?.presentedViewController != nil {
            if currentViewController == viewController {
                topPresentedViewController?.dismiss(animated: animated, completion: {
                    self.pop(animated: false)
                    self.pushViewController(viewController: viewController, animated: false)
                    self.setParameter(to: viewController, parameter: parameter)
                })
            } else {
                topPresentedViewController?.dismiss(animated: animated, completion: {
                    self.pushViewController(viewController: viewController, animated: animated)
                    self.setParameter(to: viewController, parameter: parameter)
                })
            }
        } else {
            self.pushViewController(viewController: viewController, animated: animated)
            self.setParameter(to: viewController, parameter: parameter)
        }
    }

    func dismissAndPresent<T: Parameterizable>(
        type: T.Type,
        animated: Bool,
        with parameter: NavigationParameter? = nil
    ) {
        let viewController = AppContainer.shared.container.resolve(type)!
        if currentViewController?.presentedViewController != nil {
            topPresentedViewController?.dismiss(animated: animated, completion: { [weak self] in
                self?.topPresentedViewController?.present(viewController, animated: true)
                self?.setParameter(to: viewController, parameter: parameter)
            })
        }
    }

    func dissmissAndPop(animated: Bool, with parameter: NavigationParameter? = nil) {
        if currentViewController?.presentedViewController != nil {
            topPresentedViewController?.dismiss(animated: animated, completion: {
                self.pop(animated: animated, with: parameter)
            })
        }
    }

    func setCurrentNavigationController(_ navigationController: UINavigationController) {
        currentNavigationController = navigationController
    }

    func navigateToUrl(_ url: URL) {
        UIApplication.shared.open(url)
    }
}

// MARK: - Helpers
extension ScreenNavigator {
    var topPresentedViewController: UIViewController? {
        return followPresentedViewController(currentViewController)
    }

    private func rootViewController(viewController: UIViewController) {
        if window.rootViewController == viewController && currentViewController?.presentedViewController == nil {
            navigationController?.popToRootViewController(animated: true)
        }

        if currentViewController?.presentedViewController != nil {
            currentViewController?.dismiss(animated: false, completion: { [weak self] in
                guard let navController = viewController as? UINavigationController else {
                    self?.window.rootViewController = HeroesNavigationController(rootViewController: viewController)
                    return
                }
                navController.popToRootViewController(animated: false)
                self?.window.rootViewController = navController
            })
        } else {
            guard let navController = viewController as? UINavigationController else {
                window.rootViewController = HeroesNavigationController(rootViewController: viewController)
                return
            }

            if let presentedViewController = navController.presentedViewController {
                presentedViewController.dismiss(animated: false)
            }

            navController.popToRootViewController(animated: false)
            window.rootViewController = navController
        }

        currentNavigationController = nil
    }

    private func pushViewController(viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)

        if navigationController?.isNavigationBarHidden == true {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }

    private func modalViewController(viewController: UIViewController, animated: Bool = true) {
        if currentViewController == viewController {
            return
        }

        if let presentedViewController = currentViewController?.presentedViewController {
            presentedViewController.dismiss(animated: animated, completion: nil)
        }

        topPresentedViewController?.present(viewController, animated: animated)
    }

    private func setParameter<T: Parameterizable>(to viewController: T, parameter: NavigationParameter? = nil) {
        guard let parameter = parameter else { return }
        viewController.setParameter(param: parameter)
    }

    func followPresentedViewController(_ from: UIViewController?) -> UIViewController? {
        if let to = from?.presentedViewController, to.isBeingDismissed == false {
            return followPresentedViewController(to)
        }
        return from
    }
}
