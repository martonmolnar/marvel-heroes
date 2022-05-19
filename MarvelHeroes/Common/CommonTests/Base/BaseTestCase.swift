//
//  BaseTestCase.swift
//  CommonTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import XCTest
import Swinject
import SwiftyMocky

@testable import Common

open class BaseTestCase: XCTestCase {
    public var container: Container!

    public var testError: Error {
        NSError(domain: "test",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "test"])
    }

    open override func setUp() {
        super.setUp()
        container = Container()
        AppContainer.shared.container = container

        Matcher.default = Matcher()
    }

    open override func tearDown() {
        AppContainer.shared.container.removeAll()
        AppContainer.shared.container = nil
        container = nil
        super.tearDown()
    }
    public func expectFatalError(expectedMessage: String? = nil, testcase: @escaping () -> Void) {
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String?
        AssertionWrapper.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        waitForExpectations(timeout: 2) { _ in
            if let expectedMessage = expectedMessage {
                XCTAssertEqual(assertionMessage, expectedMessage)
            }
            AssertionWrapper.restoreFatalError()
        }
    }
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}
