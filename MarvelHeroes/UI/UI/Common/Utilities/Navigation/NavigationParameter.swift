//
//  NavigationParameter.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Domain

public enum NavigationParameter {
    case heroDetails(Hero)
}

extension NavigationParameter {
    public func getParam<T>() -> T? {
        switch self {
        case .heroDetails(let hero): return hero as? T
        }
    }
}
