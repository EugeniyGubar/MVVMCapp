import XCTest

@testable import MVVMCapp

class DetailsUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testSorting() throws {
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

        let sortedAsIsText: String = textView.value as? String ?? String()

        XCTAssertTrue(!sortedAsIsText.isEmpty)

        let splittedStrings = divide(string: sortedAsIsText)

        XCTAssertTrue(!splittedStrings.isEmpty)

        let segmentedControlAscendingButton = app.segmentedControls.buttons["A-Z"]
        let segmentedControlDescendingButton = app.segmentedControls.buttons["Z-A"]
        XCTAssertTrue(segmentedControlAscendingButton.exists)
        XCTAssertTrue(segmentedControlAscendingButton.isHittable)
        XCTAssertTrue(segmentedControlDescendingButton.exists)
        XCTAssertTrue(segmentedControlDescendingButton.isHittable)

        // Test sort ascending
        segmentedControlAscendingButton.tap()

        let sortedAscendingText: String = textView.value as? String ?? String()

        XCTAssertTrue(!sortedAscendingText.isEmpty)

        let sortedAscendingAndMergedManually = sortAndMerge(strings: splittedStrings, order: .ascending)
        XCTAssertTrue(!sortedAscendingAndMergedManually.isEmpty)
        XCTAssertTrue(sortedAscendingText == sortedAscendingAndMergedManually)

        // Test sort descending
        segmentedControlDescendingButton.tap()

        let sortedDescendingText: String = textView.value as? String ?? String()

        XCTAssertTrue(!sortedDescendingText.isEmpty)

        let sortedDescendingAndMergedManually = sortAndMerge(strings: splittedStrings, order: .descending)
        XCTAssertTrue(!sortedDescendingAndMergedManually.isEmpty)
        XCTAssertTrue(sortedDescendingText == sortedDescendingAndMergedManually)
    }

    private func merge(_ strings: [String]) -> String {
        var mergedString = String()
        strings.forEach {
            mergedString.append($0 + "\n")
        }
        return mergedString
    }

    private func sort(_ strings: [String], order: SortingOrder) -> [String] {
        switch order {
        case .ascending:
            return strings.sorted { $0.lowercased() < $1.lowercased() }
        case .descending:
            return strings.sorted { $0.lowercased() > $1.lowercased() }
        case .asIs:
            return strings
        }
    }

    private func sortAndMerge(strings: [String], order: SortingOrder) -> String {
        let sortedStrings = sort(strings, order: order)
        return merge(sortedStrings)
    }

    private func divide(string: String) -> [String] {
        var dividedStrings: [String] = []
        string.enumerateLines(invoking: {
            line, _ in
            dividedStrings.append(line)
        })

        return dividedStrings
    }

}
