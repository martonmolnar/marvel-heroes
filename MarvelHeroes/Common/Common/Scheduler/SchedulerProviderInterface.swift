//
//  SchedulerProviderInterface.swift
//  Common
//
//  Created by Molnar Marton on 2022. 05. 15..
//

import RxSwift

public protocol SchedulerProviderInterface: AutoMockable  {
    var mainScheduler: SchedulerType { get }
}
