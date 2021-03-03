import UIKit
import MVVMCapp

final class CoordinatorMock: MainCoordinatorProtocol {

    // func start(_ navigationController: UINavigationController)
    var startAction: ((UINavigationController) -> Void) = { _ in }
    var startCallCount: Int = 0
    var startWasCalled: Bool {
        startCallCount > 0
    }

    func start(_ navigationController: UINavigationController) {
        startCallCount += 1
        startAction(navigationController)
    }

    // func goToLogin()
    var goToLoginAction: (() -> Void) = {}
    var goToLoginCallCount: Int = 0
    var goToLoginWasCalled: Bool {
        goToLoginCallCount > 0
    }

    func goToLogin() {
        goToLoginCallCount += 1
        goToLoginAction()
    }

    // func goToDetails()
    var goToDetailsAction: (() -> Void) = {}
    var goToDetailsCallCount: Int = 0
    var goToDetailsWasCalled: Bool {
        goToDetailsCallCount > 0
    }

    func goToDetails() {
        goToDetailsCallCount += 1
        goToDetailsAction()
    }

    // func showAlert(title: String, message: String, buttonText: String)
    var showAlertAction: ((String, String, String) -> Void) = { _, _, _ in}
    var showAlertCallCount: Int = 0
    var showAlertWasCalled: Bool {
        showAlertCallCount > 0
    }

    func showAlert(title: String, message: String, buttonText: String) {
        showAlertCallCount += 1
        showAlertAction(title, message, buttonText)
    }
}
