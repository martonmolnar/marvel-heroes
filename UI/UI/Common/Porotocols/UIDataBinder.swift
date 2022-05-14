//
//  UIDataBinder.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 14..
//

public protocol UIDataBinder {
    associatedtype Data

    func bind(data: Data)
}
