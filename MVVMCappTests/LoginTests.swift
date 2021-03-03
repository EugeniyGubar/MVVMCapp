import XCTest

@testable import MVVMCapp

class LoginTests: XCTestCase {
    private var validatorMock: ValidatorMock!
    private var coordinatorMock: CoordinatorMock!
    private var loginViewModel: LoginViewModelProtocol!

    override func setUp() {
        super.setUp()

        validatorMock = ValidatorMock()
        coordinatorMock = CoordinatorMock()
        loginViewModel = LoginViewModel(
            coordinator: coordinatorMock,
            validator: validatorMock
        )
    }

    override func tearDown() {
        validatorMock = nil
        coordinatorMock = nil
        loginViewModel = nil

        super.tearDown()
    }

    func testValidateCredentialsSuccess() {
        let credentials = Credentials(userName: String(), password: String())
        loginViewModel.validateCredentials(credentials: credentials)

        XCTAssert(validatorMock.isValidWasCalled)
        XCTAssert(validatorMock.isValidCallCount == 1)

        XCTAssert(coordinatorMock.goToDetailsWasCalled)
        XCTAssert(coordinatorMock.goToDetailsCallCount == 1)
    }

    func testValidateCredentialsFailure() {
        validatorMock.isValidAction = { _ in false }
        let credentials = Credentials(userName: String(), password: String())
        loginViewModel.validateCredentials(credentials: credentials)

        XCTAssert(validatorMock.isValidWasCalled)
        XCTAssert(validatorMock.isValidCallCount == 1)

        XCTAssert(coordinatorMock.showAlertWasCalled)
        XCTAssert(coordinatorMock.showAlertCallCount == 1)
    }
}
