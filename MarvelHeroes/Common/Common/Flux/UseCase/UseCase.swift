//
//  UseCase.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public protocol UseCase: AutoMockable {
    func execute()
}

public extension UseCase {
    func execute() { /* no-op */ }
}
