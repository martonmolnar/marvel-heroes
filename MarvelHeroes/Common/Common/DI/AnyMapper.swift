//
//  AnyMapper.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public final class AnyMapper<InputModel, OutputModel>: Mapper {
    private let mapObject: (InputModel) -> OutputModel

    public init<M: Mapper>(wrappedMapper: M) where M.InputModel == InputModel, M.OutputModel == OutputModel {
        mapObject = wrappedMapper.map
    }

    public func map(from apiModel: InputModel) -> OutputModel {
        mapObject(apiModel)
    }
}

public final class AnyThrowableMapper<InputModel, OutputModel>: ThrowableMapper {
    private let mapObject: (InputModel) throws -> OutputModel

    public init<M: ThrowableMapper>(wrappedMapper: M) where M.InputModel == InputModel, M.OutputModel == OutputModel {
        mapObject = wrappedMapper.map
    }

    public func map(from apiModel: InputModel) throws -> OutputModel {
        try mapObject(apiModel)
    }
}

