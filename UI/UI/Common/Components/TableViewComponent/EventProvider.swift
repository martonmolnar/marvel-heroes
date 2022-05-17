//
//  EventProvider.swift
//  OTPBank
//
//  Created by Mate Papp on 2019. 03. 07..
//  Copyright © 2019. Supercharge Ltd. All rights reserved.
//

import RxSwift

public protocol EventProvider {
    associatedtype Events

    var events: Events { get }
}

public protocol CellEventProvider: EventProvider {
    var bag: DisposeBag { get }
}
