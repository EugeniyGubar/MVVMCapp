import UIKit

final class MainCoordinator: MainCoordinatorProtocol {
    weak var navigationController: UINavigationController?

    func start(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func goToLogin() {
        print("goToLogin")
        navigationController?.pushViewController(loginViewController, animated: true)
    }

    func goToDetails() {
        print("goToDetails")
        navigationController?.pushViewController(detailsViewController, animated: true)
    }

    func showAlert(title: String, message: String, buttonText: String) {
        print("showAlert")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonText, style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        navigationController?.topViewController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Login
private extension MainCoordinator {
    var loginViewController: LoginViewControllerProtocol {
        LoginViewController(viewModel: loginViewModel)
    }

    var loginViewModel: LoginViewModelProtocol {
        LoginViewModel(coordinator: self, validator: Validator())
    }
}

// MARK: - Details
private extension MainCoordinator {
    var detailsViewController: DetailsViewControllerProtocol {
        DetailsViewController(viewModel: detailsViewModel)
    }

    var detailsViewModel: DetailsViewModelProtocol {
        DetailsViewModel(coordinator: self, apiManager: APIManager(), sorter: Sorter(), merger: Merger())
    }
}
