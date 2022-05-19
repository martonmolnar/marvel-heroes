//
//  AnyMapperTests.swift
//  CommonTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import XCTest
import SwiftyMocky

@testable import Common


// MARK: Definition
final class AnyMapperTests: BaseTestCase {
    private var mockMapper: MapperMock<String, Int>!
    private var sut: AnyMapper<String, Int>!

    override func setUp() {
        super.setUp()
        mockMapper = MapperMock<String, Int>()
        sut = AnyMapper(wrappedMapper: mockMapper)
    }

    override func tearDown() {
        mockMapper = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: Tests
extension AnyMapperTests {
    func testMap() {
        // Given
        let mockString = "1"
        Given(mockMapper, .map(from: .value(mockString), willReturn: 1))

        // When
        _ = sut.map(from: mockString)

        // Then
        Verify(mockMapper, .once, .map(from: .value(mockString)))
    }
}

