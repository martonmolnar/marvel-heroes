//
//  DispatcherInterface.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public typealias DispatchToken = String

public protocol DispatcherInterface {
    func dispatch(_ action: Action)
    func register<T: Store>(store: T) -> DispatchToken
    func unregister(token: DispatchToken?)
}
