//
//  BastStoreTests.swift
//  CoreTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Foundation
import XCTest
import RxTest
import RxSwift
import RxSwiftExt
import SwiftyMocky
import Common
import Nimble

@testable import Core

private struct MockState: State {}

final class BaseStoreTests: BaseTestCase {
    private var scheduler: TestScheduler!
    private var schedulerProvider: SchedulerProviderInterfaceMock!
    private var sut: BaseStore<MockState>!
    private var bag: DisposeBag!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        schedulerProvider = SchedulerProviderInterfaceMock()
        bag = DisposeBag()
        sut = BaseStore<MockState>(state: MockState(),
                                   schedulerProvider: schedulerProvider)
    }

    override func tearDown() {
        scheduler = nil
        schedulerProvider = nil
        sut = nil
        bag = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension BaseStoreTests {
    func testDeinit() {
        // Given
        let mockToken = "mockToken"
        let dispatcher = DispatcherInterfaceMock()

        // When
        sut.setDispatchToken(mockToken, onDeinit: {
            dispatcher.unregister(token: mockToken)
        })
        sut = nil

        // Then
        Verify(dispatcher, .once, .unregister(token: .value(mockToken)))
    }

    func testSetDispactToken() {
        // Given
        let mockToken = "mockToken"

        // When
        sut.setDispatchToken(mockToken) {}

        // Then
        expect(self.sut.dispatchToken()).to(equal(mockToken))
    }

    func testGetState() {
        // Given
        Given(schedulerProvider, .mainScheduler(getter: scheduler))
        let listener = scheduler.createObserver(MockState.self)

        // When
        sut.getState()
            .bind(to: listener)
            .disposed(by: bag)
        scheduler.start()

        // Then
        XCTAssertEqual(listener.events, [
            .next(1, MockState())
        ])
    }

    func testReduce() {
        // Given
        let mockAction = ActionMock()

        // When
        expectFatalError {
            self.sut.reduce()(mockAction)
        }
    }
}

