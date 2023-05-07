//
//  PeopleUITests.swift
//  PeopleUITests
//
//  Created by Ifeanyi Onuoha on 07/05/2023.
//

import XCTest

final class PeopleUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }
    
    func predicate(identifier: String) -> NSPredicate {
        return NSPredicate(format: "identifier CONTAINS '\(identifier)'")
    }

    func testApp() {
        
        let people = app.buttons.containing(predicate(identifier: "person_"))
        
        XCTAssertTrue(people.element.waitForExistence(timeout: 5))
        
        XCTAssertTrue(people.count >= 6)
        
        people.firstMatch.tap()

        XCTAssertTrue(app.staticTexts["Details"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["#1"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["First Name"].exists)
        XCTAssertTrue(app.staticTexts["George"].exists)
        XCTAssertTrue(app.staticTexts["Last Name"].exists)
        XCTAssertTrue(app.staticTexts["Bluth"].exists)
        XCTAssertTrue(app.staticTexts["Email"].exists)
        XCTAssertTrue(app.staticTexts["george.bluth@reqres.in"].exists)
        XCTAssertTrue(app.staticTexts["Support Reqres"].exists)

        app.navigationBars.buttons.firstMatch.tap()

        app.navigationBars.buttons["createButton"].tap()

        XCTAssertTrue(app.staticTexts["Create"].waitForExistence(timeout: 5))

        app.navigationBars.buttons["doneButton"].tap()

        XCTAssertTrue(app.staticTexts["People"].waitForExistence(timeout: 5))

        app.navigationBars.buttons["createButton"].tap()

        XCTAssertTrue(app.staticTexts["Create"].waitForExistence(timeout: 5))

        let firstName = app.textFields["First Name"]
        XCTAssertTrue(firstName.exists)
        firstName.tap()
        firstName.typeText("Ifeanyi")

        let job = app.textFields["Job"]
        XCTAssertTrue(job.exists)
        job.tap()
        job.typeText("Developer")

        app.buttons["submitButton"].tap()

        XCTAssertTrue(app.staticTexts["Last name cannot be blank"].waitForExistence(timeout: 5))

        let lastName = app.textFields["Last Name"]
        XCTAssertTrue(lastName.exists)
        lastName.tap()
        lastName.typeText("Onuoha")

        app.buttons["submitButton"].tap()

        XCTAssertFalse(app.staticTexts["Last name cannot be blank"].exists)

        let successPopUp = app.images["successPopUp"]

        XCTAssertTrue(successPopUp.waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["People"].waitForExistence(timeout: 5))
        
        let settingsBtn = app.tabBars.buttons["settingsTab"]
        XCTAssertTrue(settingsBtn.exists)
        
        settingsBtn.tap()
        XCTAssertTrue(app.staticTexts["Settings"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Haptic Feedback"].exists)
        
    }
}
