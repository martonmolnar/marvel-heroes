//
//  EventListener.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

public protocol EventListener {
    associatedtype Events

    func listen(events: Events)
}
