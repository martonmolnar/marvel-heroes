//
//  ResolverGetTest.swift
//  CommonTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import Foundation
import XCTest
import SwiftyMocky
import Swinject
import Nimble

@testable import Common

// MARK: Definition
final class ResolverGetTest: BaseTestCase {
    private var sut: Container!

    override func setUp() {
        super.setUp()
        sut = Container()
    }

    override func tearDown() {
        sut.removeAll()
        sut = nil
        super.tearDown()
    }
}

extension ResolverGetTest {
    /// When store registered
    /// AND GET called
    /// THEN it emits the store
    func testGet() {
        // Given
        let expectedStore = TestStore(name: "test")
        sut.register(TestStore.self) { _ in expectedStore }

        // When
        let test: TestStore = sut.get()

        // Then
        expect(test).toNot(beNil())
        expect(test).to(equal(expectedStore))
    }

    /// When store registered with name
    /// AND GET called with name
    /// THEN it emits the store
    func testGetWithName() {
        // Given
        let expectedStore = TestStore(name: "test")
        let storeName = "awesome store name"
        sut.register(TestStore.self, name: storeName) { _ in expectedStore }
        sut.register(TestStore.self) { _ in TestStore(name: "it is not the expected store") }

        // When
        let test: TestStore = sut.get(name: storeName)

        // Then
        expect(test).toNot(beNil())
        expect(test).to(equal(expectedStore))
        expect(test.name).to(equal(expectedStore.name))
    }

    /// When store registered with name
    /// AND GET called without name
    /// THEN it emits fatal error
    func testGetFatalError() {
        // Given
        let expectedStore = TestStore(name: "test")
        let storeName = "awesome store name"
        sut.register(TestStore.self, name: storeName) { _ in expectedStore }

        // Then
        expectFatalError { let _: TestStore = self.sut.get() }
    }
}

private class TestStore: Equatable {
    static func == (lhs: TestStore, rhs: TestStore) -> Bool {
        lhs.name == rhs.name
    }
    let name: String

    init(name: String) {
        self.name = name
    }
}
