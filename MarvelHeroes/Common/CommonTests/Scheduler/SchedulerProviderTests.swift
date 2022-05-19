//
//  SchedulerProviderTests.swift
//  CommonTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import XCTest
import Nimble
import RxSwift

@testable import Common

class SchedulerProviderTests: BaseTestCase {

    var sut: SchedulerProvider!

    func testInit() {
        // Given
        var sut: SchedulerProviderInterface
        let mainScheduler = MainScheduler()
        // When
        sut = SchedulerProvider(mainScheduler: mainScheduler)
        // Then
        expect(sut.mainScheduler).to(be(mainScheduler))
    }
}

