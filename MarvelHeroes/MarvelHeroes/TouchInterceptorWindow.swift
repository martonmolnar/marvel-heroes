//
//  TouchInterceptorWindow.swift
//  MarvelHeroes
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import UIKit

/// Represents a `UIWindow` which will intercept the touch events.
public final class TouchInterceptorWindow: UIWindow {
    // MARK: Properties

    // MARK: Initialization
    public init() {
        super.init(frame: UIScreen.main.bounds)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

