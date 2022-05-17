//
//  DataBinder.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public protocol DataBinder {
    associatedtype Data

    func bind() -> Data
}
