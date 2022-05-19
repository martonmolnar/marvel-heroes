//
//  EventListener.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

// sourcery: associatedtype = "Events"
public protocol EventListener: AutoMockable {
    associatedtype Events

    func listen(events: Events)
}
