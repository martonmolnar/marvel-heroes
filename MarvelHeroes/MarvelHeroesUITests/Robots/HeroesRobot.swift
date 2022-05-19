//
//  HeroesRobot.swift
//  MarvelHeroesTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import XCTest

private enum AccessibilityId {
    enum HeroesListScreen {
        static let searchFieldId = "searchField_inputfield_id"
    }
}

enum ListFlowCase: String {
    case success = "FlowSuccess"
}

final class HeroesRobot {

    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func startApp() {
        startApp(with: .success)
    }

    func startApp(with flowCase: ListFlowCase) {
        app.launchEnvironment = ["testCase": flowCase.rawValue]
        app.launch()
        checkInitialState()
    }

    func checkInitialState() {
        // Given
        let searchField = app.textFields[AccessibilityId.HeroesListScreen.searchFieldId]

        // Then
        XCTAssert(searchField.waitForExistence(timeout: 5))
    }
}
