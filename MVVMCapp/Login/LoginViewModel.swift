final public class LoginViewModel: LoginViewModelProtocol {
    private struct Constant {
        static let errorTitle: String = "Error"
        static let errorMessage: String = "Wrong credentials"
        static let errorButtonText: String = "OK"
    }

    private var coordinator: MainCoordinatorProtocol?
    private let validator: ValidatorProtocol

    init(coordinator: MainCoordinatorProtocol?, validator: ValidatorProtocol) {
        self.coordinator = coordinator
        self.validator = validator
    }

    public func validateCredentials(credentials: Credentials) {
        if validator.isValid(credentials: credentials) {
            coordinator?.goToDetails()
        } else {
            coordinator?.showAlert(
                title: Constant.errorTitle,
                message: Constant.errorMessage,
                buttonText: Constant.errorButtonText
            )
        }
    }
}
