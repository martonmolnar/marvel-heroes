//
//  Dispatcher.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public final class Dispatcher {
    // MARK: - Properties
    private var reducers = [DispatchToken: Reducer]()
    private lazy var serialQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = ""
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInteractive
        return queue
    }()
    private lazy var reducerQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = ""
        queue.qualityOfService = .userInteractive
        return queue
    }()

    // MARK: - Lifecycle
    public init() { /* no op */ }
}

// MARK: - DispatcherInterface
extension Dispatcher: DispatcherInterface {
    public func dispatch(_ action: Action) {
        serialQueue.addOperation { [weak self] in
            guard let reducers = self?.reducers else { return }
            var ops = [Operation]()
            for (_, callback) in reducers {
                let op = BlockOperation {
                    callback(action)
                }
                ops.append(op)
            }

            self?.reducerQueue.addOperations(ops, waitUntilFinished: true)
        }
    }

    public func register<T: Store>(store: T) -> DispatchToken {
        let dispatchToken = UUID().uuidString

        let operation = BlockOperation { [weak self] in
            self?.reducers[dispatchToken] = store.reduce()
        }
        operation.queuePriority = .veryHigh
        serialQueue.addOperation(operation)

        return dispatchToken
    }

    public func unregister(token: DispatchToken?) {
        guard let token = token else { return }

        let operation = BlockOperation { [weak self] in
            _ = self?.reducers.removeValue(forKey: token)
        }
        operation.queuePriority = .veryHigh
        serialQueue.addOperation(operation)
    }
}

