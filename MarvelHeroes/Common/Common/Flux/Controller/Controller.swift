//
//  Controller.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 18..
//

public protocol Controller {
    associatedtype DataBinderType: DataBinder
    associatedtype EventListenerType: EventListener

    var dataBinder: DataBinderType? { get }
    var eventListener: EventListenerType? { get }
}
