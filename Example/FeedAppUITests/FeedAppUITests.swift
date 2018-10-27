//
//  FeedAppUITests.swift
//  FeedAppUITests
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import XCTest

class FeedAppUITests: XCTestCase {

    // MARK: -

    func testExample() {
        let app = XCUIApplication(bundleIdentifier: "com.rzeszot.FeedApp")
        app.terminate()

        app.launchArguments = ["--mocked-network"]
        app.launch()

        // feed screen
        XCTAssertTrue(app.buttons["feed-add-button"].exists)
        XCTAssertTrue(app.buttons["feed-refresh-button"].exists)
        XCTAssertTrue(app.tables["feed-tableview"].exists)

        var cells = app.tables["feed-tableview"].cells
        XCTAssertEqual(cells.count, 3)
        XCTAssertEqual(cells.element(boundBy: 0).staticTexts["content"].label, "test 0")
        XCTAssertEqual(cells.element(boundBy: 1).staticTexts["content"].label, "test 1")
        XCTAssertEqual(cells.element(boundBy: 2).staticTexts["content"].label, "test 2")

        app.buttons["feed-add-button"].tap()

        // add screen
        XCTAssertTrue(app.textViews["add-textview"].exists)
        XCTAssertTrue(app.buttons["add-back-button"].exists)
        XCTAssertTrue(app.buttons["add-send-button"].exists)

        app.textViews["add-textview"].typeText("this is example post")
        app.buttons["add-send-button"].tap()

        // main screen
        cells = app.tables["feed-tableview"].cells
        XCTAssertEqual(cells.count, 4)
        XCTAssertEqual(cells.element(boundBy: 0).staticTexts["content"].label, "test 0")
        XCTAssertEqual(cells.element(boundBy: 1).staticTexts["content"].label, "test 1")
        XCTAssertEqual(cells.element(boundBy: 2).staticTexts["content"].label, "test 2")
        XCTAssertEqual(cells.element(boundBy: 3).staticTexts["content"].label, "this is example post")
    }

}
