//
//  TableViewComponentConfig.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common

struct TableViewComponentConfig {
    let pullToRefreshEnabled: Bool
}

// MARK: - Equatable
extension TableViewComponentConfig: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.pullToRefreshEnabled == rhs.pullToRefreshEnabled
    }
}

// MARK: - DefaultValueInitiable
extension TableViewComponentConfig: DefaultValueInitiable {
    static func defaultValue() -> Self {
        return TableViewComponentConfig(pullToRefreshEnabled: true)
    }
}

