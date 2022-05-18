//
//  Mapper.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

// sourcery: associatedtype = "InputModel"
// sourcery: associatedtype = "OutputModel"
public protocol Mapper: AutoMockable {
    associatedtype InputModel
    associatedtype OutputModel

    func map(from model: InputModel) -> OutputModel
}

public protocol ThrowableMapper {
    associatedtype InputModel
    associatedtype OutputModel

    func map(from model: InputModel) throws -> OutputModel
}
