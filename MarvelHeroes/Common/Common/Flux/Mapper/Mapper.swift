//
//  Mapper.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public protocol Mapper {
    associatedtype InputModel
    associatedtype OutputModel

    func map(from model: InputModel) -> OutputModel
}

public protocol ThrowableMapper {
    associatedtype InputModel
    associatedtype OutputModel

    func map(from model: InputModel) throws -> OutputModel
}
