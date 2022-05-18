//
//  Store.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import RxSwift

public typealias Reducer = (Action) -> Void

// sourcery: associatedtype = "BoundedContext: State"
public protocol Store: AutoMockable {
    associatedtype BoundedContext: State

    func setDispatchToken(_ token: DispatchToken?, onDeinit: @escaping () -> Void)
    func dispatchToken() -> DispatchToken?
    func getState() -> Observable<BoundedContext>
    func reduce() -> Reducer
}
