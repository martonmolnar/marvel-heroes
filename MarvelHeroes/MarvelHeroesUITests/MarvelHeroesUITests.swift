//
//  MarvelHeroesUITests.swift
//  MarvelHeroesUITests
//
//  Created by Molnar Marton on 2022. 05. 14..
//

import XCTest

class MarvelHeroesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        checkInitialState(app: app)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    func checkInitialState(app: XCUIApplication) {
        // Given
        let searchField = app.textFields[AccessibilityId.HeroesListScreen.searchFieldId]
        let cell = app.cells[AccessibilityId.HeroesListScreen.cellId]
        // Then
        XCTAssert(searchField.waitForExistence(timeout: 5))
        XCTAssert(cell.waitForExistence(timeout: 5))
    }
}

private enum AccessibilityId {
    enum HeroesListScreen {
        static let searchFieldId = "searchfieldcomponent_searchField_inputfield_id"
        static let cellId = "0_0_listCell_cell_id"
    }
}
