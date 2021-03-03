import UIKit

protocol LoginViewControllerProtocol: UIViewController {

}

public protocol LoginViewModelProtocol {
    func validateCredentials(credentials: Credentials)
}
