//
//  AnyStoreTests.swift
//  CommonTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import XCTest
import SwiftyMocky

@testable import Common

private struct MockState: State {}

// MARK: Definition
final class AnyStoreTests: BaseTestCase {
    private var mockStore: StoreMock<MockState>!
    private var sut: AnyStore<MockState>!

    override func setUp() {
        super.setUp()
        mockStore = StoreMock<MockState>()
        sut = AnyStore(wrappedStore: mockStore)
    }

    override func tearDown() {
        mockStore = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: Tests
extension AnyStoreTests {
    func testSetDispactToken() {
        // Given
        let mockToken = "mockToken"

        // When
        sut.setDispatchToken(mockToken) {}

        // Then
        Verify(mockStore, .once, .setDispatchToken(.value(mockToken), onDeinit: .any))
    }

    func testGetDispatchToken() {
        // When
        _ = sut.dispatchToken()

        // Then
        Verify(mockStore, .once, .dispatchToken())
    }

    func testGetState() {
        // Given
        Given(mockStore, .getState(willReturn: .just(.init())))

        // When
        _ = sut.getState()

        // Then
        Verify(mockStore, .once, .getState())
    }

    func testReduce() {
        // Given
        let mockAction = ActionMock()
        Given(mockStore, .reduce(willReturn: { _ in }))

        // When
        sut.reduce()(mockAction)
        // Then
        Verify(mockStore, .once, .reduce())
    }
}

