//
//  TestProjectUITests.swift
//  TestProjectUITests
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest

class TestProjectUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments += ["UITesting"]
    }

    private func getJSONStringFromFileName(name: String) -> String {
        let bundle = Bundle(for: type(of: self))
        if let filePath = bundle.path(forResource: name, ofType: "json") {
            let jsonString = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            return jsonString ?? ""
        }
        return ""
    }

    func testUIFlowForNavBarButtons() {
        app.launchEnvironment["https://pavanvalluru.github.io/sampleServer/listings.json"] =
            getJSONStringFromFileName(name: "testData")
        app.launch()
        let mainTabBar = app.tabBars["MainTabBar"]

        let homeButton = mainTabBar.buttons["Home"]
        homeButton.tap()
        XCTAssertTrue(app.navigationBars["Home"].exists, "Listings view visible")

        let favoritesButton = mainTabBar.buttons["Favorites"]
        favoritesButton.tap()
        XCTAssertTrue(app.navigationBars["Favorites"].exists, "Favorites view visible")
    }

    func testTableviewCells() {
        app.launchEnvironment["https://pavanvalluru.github.io/sampleServer/listings.json"] =
            getJSONStringFromFileName(name: "testData")
        app.launch()
        let listingsTableview = app.tables["listingsTable"]

        XCTAssertTrue(listingsTableview.exists, "Listings tableview exists")

        let tableCells = listingsTableview.cells

        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)

            let promise = expectation(description: "Wait for table cells")

            for val in stride(from: 0, to: count, by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let tableCell = tableCells.element(boundBy: val)
                XCTAssertTrue(tableCell.exists, "The \(val) cell is in place on the table")
                // Does this actually take us to the next screen
                tableCell.tap()

                if val == (count - 1) {
                    promise.fulfill()
                }
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")

        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }

    func testForInvalidResultAlert() {
        app.launchEnvironment["https://pavanvalluru.github.io/sampleServer/listings.json"] = nil
        app.launch()

        let alert = app.alerts["Error"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)

        alert.buttons["Okay"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "Home")
    }

    func testNoNetworkAlert() {
        app.launchEnvironment["Offline"] = "1"
        app.launch()

        // Relaunch app without restarting it
        app.activate()

        let alert = app.alerts["Error"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)

        XCTAssert(app.alerts.element.staticTexts["Mocked Internet connection appears to be offline."].exists)

        alert.buttons["Okay"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "Home")
    }

}
