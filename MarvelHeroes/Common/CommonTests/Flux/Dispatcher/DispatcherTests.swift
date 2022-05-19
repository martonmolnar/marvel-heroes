//
//  DispatcherTests.swift
//  CommonTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import XCTest
import SwiftyMocky
import Nimble
import RxSwift

@testable import Common

// MARK: Definition

private enum MockState: State {}
private enum MockAction: Action, Equatable { case A, B, C(index: Int) }

final class DispatcherTests: BaseTestCase {
    private var sut: Dispatcher!
    private var store: StoreMock<MockState>!
    private var bag: DisposeBag!

    override func setUp() {
        super.setUp()
        sut = Dispatcher()
        store = StoreMock<MockState>()
        bag = DisposeBag()
    }

    override func tearDown() {
        sut = nil
        store = nil
        bag = nil
        super.tearDown()
    }
}

// MARK: Tests
extension DispatcherTests {
    func testRegisterStore() {
        // Given
        Given(store, .reduce(willReturn: { _ in }))

        // When
        let result = sut.register(store: store)

        // Then
        expect(result).toNot(beNil())
        Verify(store, .once, .reduce())
    }

    func testDispatchAction() throws {
        // Given
        let givenAction = MockAction.A
        let expect = expectation(description: "Store's reduce function should be called with the dispatched action by the sut.")

        Given(store, .reduce(willReturn: { action in
            guard let action = action as? MockAction else { return }
            guard action == givenAction else { return }
            DispatchQueue.main.async { expect.fulfill() }
        }))

        _ = sut.register(store: store)

        // When
        sut.dispatch(givenAction)

        // Then
        waitForExpectations(timeout: 3)
        Verify(store, .once, .reduce())
    }

    func testUnRegisterStore() {
        // Given
        let expect = expectation(description: "Store's reduce function should NOT be called with the dispatched action by the sut.")
        expect.isInverted = true

        Given(store, .reduce(willReturn: { _ in
            DispatchQueue.main.async { expect.fulfill() }
        }))

        let token = sut.register(store: store)

        // When
        sut.unregister(token: token)
        sut.dispatch(ActionMock())

        // Then
        waitForExpectations(timeout: 3)
    }

    func testDispatchMultipleActionsToMultipleStoresInOrder() {
        // Given
        let store1 = StoreMock<MockState>()
        let store2 = StoreMock<MockState>()
        let store3 = StoreMock<MockState>()
        let store4 = StoreMock<MockState>()
        let store5 = StoreMock<MockState>()
        let store6 = StoreMock<MockState>()
        let store7 = StoreMock<MockState>()
        let store8 = StoreMock<MockState>()
        let store9 = StoreMock<MockState>()
        let store10 = StoreMock<MockState>()
        let actionA = MockAction.A
        let actionB = MockAction.B

        let actionA_Store1_Expectation1 = expectation(description: "A-1-1")
        let actionA_Store1_Expectation2 = expectation(description: "A-1-2")

        let actionA_Store2_Expectation1 = expectation(description: "A-2-1")
        let actionA_Store2_Expectation2 = expectation(description: "A-2-2")

        let actionA_Store3_Expectation1 = expectation(description: "A-3-1")
        let actionA_Store3_Expectation2 = expectation(description: "A-3-2")

        let actionA_Store4_Expectation1 = expectation(description: "A-4-1")
        let actionA_Store4_Expectation2 = expectation(description: "A-4-2")

        let actionA_Store5_Expectation1 = expectation(description: "A-5-1")
        let actionA_Store5_Expectation2 = expectation(description: "A-5-2")

        let actionA_Store6_Expectation1 = expectation(description: "A-6-1")
        let actionA_Store6_Expectation2 = expectation(description: "A-6-2")

        let actionA_Store7_Expectation1 = expectation(description: "A-7-1")
        let actionA_Store7_Expectation2 = expectation(description: "A-7-2")

        let actionA_Store8_Expectation1 = expectation(description: "A-8-1")
        let actionA_Store8_Expectation2 = expectation(description: "A-8-2")

        let actionA_Store9_Expectation1 = expectation(description: "A-9-1")
        let actionA_Store9_Expectation2 = expectation(description: "A-9-2")

        let actionA_Store10_Expectation1 = expectation(description: "A-10-1")
        let actionA_Store10_Expectation2 = expectation(description: "A-10-2")

        let actionB_Store1_Expectation1 = expectation(description: "B-1-1")
        let actionB_Store1_Expectation2 = expectation(description: "B-1-2")

        let actionB_Store2_Expectation1 = expectation(description: "B-2-1")
        let actionB_Store2_Expectation2 = expectation(description: "B-2-2")

        let actionB_Store3_Expectation1 = expectation(description: "B-3-1")
        let actionB_Store3_Expectation2 = expectation(description: "B-3-2")

        let actionB_Store4_Expectation1 = expectation(description: "B-4-1")
        let actionB_Store4_Expectation2 = expectation(description: "B-4-2")

        let actionB_Store5_Expectation1 = expectation(description: "B-5-1")
        let actionB_Store5_Expectation2 = expectation(description: "B-5-2")

        let actionB_Store6_Expectation1 = expectation(description: "B-6-1")
        let actionB_Store6_Expectation2 = expectation(description: "B-6-2")

        let actionB_Store7_Expectation1 = expectation(description: "B-7-1")
        let actionB_Store7_Expectation2 = expectation(description: "B-7-2")

        let actionB_Store8_Expectation1 = expectation(description: "B-8-1")
        let actionB_Store8_Expectation2 = expectation(description: "B-8-2")

        let actionB_Store9_Expectation1 = expectation(description: "B-9-1")
        let actionB_Store9_Expectation2 = expectation(description: "B-9-2")

        let actionB_Store10_Expectation1 = expectation(description: "B-10-1")
        let actionB_Store10_Expectation2 = expectation(description: "B-10-2")


        Given(store1, .reduce(willReturn: { action in
            print("Store 1 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store1_Expectation1.fulfill()
                    actionA_Store1_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store1_Expectation1.fulfill()
                    actionB_Store1_Expectation2.fulfill()
                }
            }
        }))

        Given(store2, .reduce(willReturn: { action in
            print("Store 2 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store2_Expectation1.fulfill()
                    actionA_Store2_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store2_Expectation1.fulfill()
                    actionB_Store2_Expectation2.fulfill()
                }
            }
        }))

        Given(store3, .reduce(willReturn: { action in
            print("Store 3 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store3_Expectation1.fulfill()
                    actionA_Store3_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store3_Expectation1.fulfill()
                    actionB_Store3_Expectation2.fulfill()
                }
            }
        }))

        Given(store4, .reduce(willReturn: { action in
            print("Store 4 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store4_Expectation1.fulfill()
                    actionA_Store4_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store4_Expectation1.fulfill()
                    actionB_Store4_Expectation2.fulfill()
                }
            }
        }))

        Given(store5, .reduce(willReturn: { action in
            print("Store 5 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store5_Expectation1.fulfill()
                    actionA_Store5_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store5_Expectation1.fulfill()
                    actionB_Store5_Expectation2.fulfill()
                }
            }
        }))

        Given(store6, .reduce(willReturn: { action in
            print("Store 6 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store6_Expectation1.fulfill()
                    actionA_Store6_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store6_Expectation1.fulfill()
                    actionB_Store6_Expectation2.fulfill()
                }
            }
        }))

        Given(store7, .reduce(willReturn: { action in
            print("Store 7 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store7_Expectation1.fulfill()
                    actionA_Store7_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store7_Expectation1.fulfill()
                    actionB_Store7_Expectation2.fulfill()
                }
            }
        }))

        Given(store8, .reduce(willReturn: { action in
            print("Store 8 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store8_Expectation1.fulfill()
                    actionA_Store8_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store8_Expectation1.fulfill()
                    actionB_Store8_Expectation2.fulfill()
                }
            }
        }))

        Given(store9, .reduce(willReturn: { action in
            print("Store 9 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store9_Expectation1.fulfill()
                    actionA_Store9_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store9_Expectation1.fulfill()
                    actionB_Store9_Expectation2.fulfill()
                }
            }
        }))

        Given(store10, .reduce(willReturn: { action in
            print("Store 10 \(action)")
            guard let action = action as? MockAction else { return }

            if action == actionA {
                DispatchQueue.main.async {
                    actionA_Store10_Expectation1.fulfill()
                    actionA_Store10_Expectation2.fulfill()
                }
            } else if action == actionB {
                DispatchQueue.main.async {
                    actionB_Store10_Expectation1.fulfill()
                    actionB_Store10_Expectation2.fulfill()
                }
            }
        }))

        _ = sut.register(store: store1)
        _ = sut.register(store: store2)
        _ = sut.register(store: store3)
        _ = sut.register(store: store4)
        _ = sut.register(store: store5)
        _ = sut.register(store: store6)
        _ = sut.register(store: store7)
        _ = sut.register(store: store8)
        _ = sut.register(store: store9)
        _ = sut.register(store: store10)

        // When
        sut.dispatch(actionA)
        sut.dispatch(actionB)

        // Then
        wait(for: [
            actionA_Store1_Expectation1,
            actionA_Store1_Expectation2,
            actionA_Store2_Expectation1,
            actionA_Store2_Expectation2,
            actionA_Store3_Expectation1,
            actionA_Store3_Expectation2,
            actionA_Store4_Expectation1,
            actionA_Store4_Expectation2,
            actionA_Store5_Expectation1,
            actionA_Store5_Expectation2,
            actionA_Store6_Expectation1,
            actionA_Store6_Expectation2,
            actionA_Store7_Expectation1,
            actionA_Store7_Expectation2,
            actionA_Store8_Expectation1,
            actionA_Store8_Expectation2,
            actionA_Store9_Expectation1,
            actionA_Store9_Expectation2,
            actionA_Store10_Expectation1,
            actionA_Store10_Expectation2
        ], timeout: 3)

        wait(for: [
            actionB_Store1_Expectation1,
            actionB_Store1_Expectation2,
            actionB_Store2_Expectation1,
            actionB_Store2_Expectation2,
            actionB_Store3_Expectation1,
            actionB_Store3_Expectation2,
            actionB_Store4_Expectation1,
            actionB_Store4_Expectation2,
            actionB_Store5_Expectation1,
            actionB_Store5_Expectation2,
            actionB_Store6_Expectation1,
            actionB_Store6_Expectation2,
            actionB_Store7_Expectation1,
            actionB_Store7_Expectation2,
            actionB_Store8_Expectation1,
            actionB_Store8_Expectation2,
            actionB_Store9_Expectation1,
            actionB_Store9_Expectation2,
            actionB_Store10_Expectation1,
            actionB_Store10_Expectation2
        ], timeout: 3)
    }

    func testRapidDispatch() {
        // Given
        let numberOfStores = 50
        let numberOfActions = 100
        var stores = [StoreMock<MockState>]()
        var actions = [MockAction]()
        var expectations = [XCTestExpectation]()

        for i in 0..<numberOfStores {
            let store = StoreMock<MockState>()
            for a in 0..<numberOfActions {
                let action = MockAction.C(index: (i * numberOfActions) + a)
                let expectation = expectation(description: "")
                expectations.append(expectation)
                actions.append(action)
            }
            let minIndex = (i * numberOfActions) - 1
            let maxIndex = (i * numberOfActions) + numberOfActions
            Given(store, .reduce(willReturn: { action in
                guard let action = action as? MockAction else { return }
                switch action{
                case .C(let index):
                    guard index > minIndex && index < maxIndex else { return }
                    let expectation = expectations[index]
                    expectation.fulfill()
                    return
                default:
                    return
                }
            }))

            _ = sut.register(store: store)
            stores.append(store)
        }

        // When
        for action in actions {
            sut.dispatch(action)
        }

        // Then
        wait(for: expectations, timeout: 60)
    }
}

