//
//  HeroesNavigationController.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

open class HeroesNavigationController: UINavigationController {
    public init() {
        super.init(navigationBarClass: nil, toolbarClass: nil)
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override public init(rootViewController: UIViewController) {
        super.init(navigationBarClass: nil, toolbarClass: nil)

        self.viewControllers = [rootViewController]
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

