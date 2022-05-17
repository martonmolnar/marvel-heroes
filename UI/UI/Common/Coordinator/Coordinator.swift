//
//  Coordinator.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common

public protocol Coordinator: AnyObject {
    var navigator: NavigatorType { get }

    func start(payload: QueryParameters?)
}

// MARK: - Start with no payload
public extension Coordinator {
    func start() {
        start(payload: nil)
    }
}
