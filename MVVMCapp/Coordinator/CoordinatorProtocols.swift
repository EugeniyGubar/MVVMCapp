import UIKit

public protocol MainCoordinatorProtocol: class {
    func start(_ navigationController: UINavigationController)
    func goToLogin()
    func goToDetails()
    func showAlert(title: String, message: String, buttonText: String)
}
