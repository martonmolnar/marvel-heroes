//
//  SchedulerProvider.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 16..
//

import RxSwift

public final class SchedulerProvider: SchedulerProviderInterface {

    public let mainScheduler: SchedulerType

    public init(mainScheduler: SchedulerType = MainScheduler()) {
        self.mainScheduler = mainScheduler
    }
}
