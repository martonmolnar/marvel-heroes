//
//  DataBinder.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

// sourcery: associatedtype = "Data"
public protocol DataBinder: AutoMockable {
    associatedtype Data

    func bind() -> Data
}
