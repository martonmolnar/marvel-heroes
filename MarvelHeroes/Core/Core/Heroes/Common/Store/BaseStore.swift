//
//  BaseStore.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import Common
import RxSwift
import RxRelay

class BaseStore<StateType: State>: Store {
    typealias BoundedContext = StateType

    private var _dispatchToken: DispatchToken?
    private var _deinitBlock: (() -> Void)?
    internal let state: BehaviorRelay<StateType>
    private let schedulerProvider: SchedulerProviderInterface

    init(state: StateType,
         schedulerProvider: SchedulerProviderInterface) {
        self.state = BehaviorRelay(value: state)
        self.schedulerProvider = schedulerProvider
    }

    deinit {
        _deinitBlock?()
    }

    func setDispatchToken(_ token: DispatchToken?, onDeinit: @escaping () -> Void) {
        _dispatchToken = token
        _deinitBlock = onDeinit
    }

    func dispatchToken() -> DispatchToken? {
        _dispatchToken
    }

    public func getState() -> Observable<StateType> {
        return state.asObservable()
            .observe(on: schedulerProvider.mainScheduler)
    }

    func reduce() -> ((Action) -> Void) {
        fatalError("")
    }

    internal func modify(_ transform: (inout StateType) -> Void) {
        var copy = state.value
        transform(&copy)
        state.accept(copy)
    }
}

