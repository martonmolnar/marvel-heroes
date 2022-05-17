//
//  EventProvider.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import RxSwift

public protocol EventProvider {
    associatedtype Events

    var events: Events { get }
}

public protocol CellEventProvider: EventProvider {
    var bag: DisposeBag { get }
}

