//
//  BaseUITestCase.swift
//  MarvelHeroesTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import XCTest

class BaseUITestCase: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UITest"]
    }

    override func tearDownWithError() throws {
//        app.terminate()
    }
}
