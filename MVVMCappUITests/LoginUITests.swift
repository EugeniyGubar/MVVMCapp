import XCTest

class LoginUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testPositiveScenario() throws {
        let userNameTextField = app.textFields["userNameTextField"]
        XCTAssertTrue(userNameTextField.exists)
        XCTAssertTrue(userNameTextField.isHittable)
        userNameTextField.tap()
        userNameTextField.typeText("user")

        let passwordTextField = app.textFields["passwordTextField"]
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(passwordTextField.isHittable)
        passwordTextField.tap()
        passwordTextField.typeText("123qwe")

        let button = app.buttons["button"]
        XCTAssertTrue(button.exists)
        XCTAssertTrue(button.isHittable)
        button.tap()

        let textView = app.textViews["textView"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: textView, handler: nil)
        waitForExpectations(timeout: TimeInterval(1.5), handler: nil)

        XCTAssertTrue(textView.exists)
        XCTAssertTrue(textView.isHittable)
    }

    func testNegativeScenario() throws {
        let userNameTextField = app.textFields["userNameTextField"]
        XCTAssertTrue(userNameTextField.exists)
        XCTAssertTrue(userNameTextField.isHittable)
        userNameTextField.tap()
        userNameTextField.typeText("user111")

        let passwordTextField = app.textFields["passwordTextField"]
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(passwordTextField.isHittable)
        passwordTextField.tap()
        passwordTextField.typeText("123qwe")

        let button = app.buttons["button"]
        XCTAssertTrue(button.exists)
        XCTAssertTrue(button.isHittable)
        button.tap()

        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(errorAlert.exists)
        XCTAssertTrue(errorAlert.isHittable)

        let okButton = errorAlert.scrollViews.otherElements.buttons["OK"]
        XCTAssertTrue(okButton.exists)
        XCTAssertTrue(okButton.isHittable)

        okButton.tap()

        XCTAssertTrue(userNameTextField.exists)
        XCTAssertTrue(userNameTextField.isHittable)

        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(passwordTextField.isHittable)

        XCTAssertTrue(button.exists)
        XCTAssertTrue(button.isHittable)
    }
}
