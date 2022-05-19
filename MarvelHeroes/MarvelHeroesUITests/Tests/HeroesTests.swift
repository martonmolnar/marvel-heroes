//
//  HeroesTests.swift
//  MarvelHeroesTests
//
//  Created by Molnar Marton on 2022. 05. 19..
//

import XCTest

final class HeroesTests: BaseUITestCase {

    private var robot: HeroesRobot!

    override func setUpWithError() throws {
        try super.setUpWithError()
        robot = HeroesRobot(app: app)
    }

    override func tearDownWithError() throws {
        robot = nil
        try super.tearDownWithError()
    }

    func testInit() throws {
        robot.startApp()
        app.terminate()
    }
}
