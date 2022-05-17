//
//  AnyStore.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import RxSwift

public final class AnyStore<T: State>: Store {
    private let setDispatchTokenObject: (DispatchToken?, _ onDeinit: @escaping () -> Void) -> Void
    private let dispatchTokenObject: () -> DispatchToken?
    private let getStateObject: () -> Observable<BoundedContext>
    private let reduceObject: () -> Reducer

    public init<U: Store>(wrappedStore: U) where U.BoundedContext == T {
        setDispatchTokenObject = wrappedStore.setDispatchToken
        dispatchTokenObject = wrappedStore.dispatchToken
        getStateObject = wrappedStore.getState
        reduceObject = wrappedStore.reduce
    }

    public func dispatchToken() -> DispatchToken? {
        dispatchTokenObject()
    }
    public func setDispatchToken(_ token: DispatchToken?, onDeinit: @escaping () -> Void) {
        setDispatchTokenObject(token, onDeinit)
    }

    public func getState() -> Observable<T> {
        getStateObject()
    }

    public func reduce() -> Reducer {
        reduceObject()
    }
}

