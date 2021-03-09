import UIKit

final class LoginViewController: UIViewController, LoginViewControllerProtocol {
    private let userNameTextField: UITextField = UITextField()
    private let passwordTextField: UITextField = UITextField()
    private let button: UIButton = UIButton()

    private let viewModel: LoginViewModelProtocol

    private var credentials: Credentials {
        .init(
            userName: userNameTextField.text ?? String(),
            password: passwordTextField.text ?? String()
        )
    }

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        let scrollView = UIScrollView()
        let containerView = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(userNameTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(button)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        ])

        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.0),
            userNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.0),
            userNameTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 150.0),
            userNameTextField.heightAnchor.constraint(equalToConstant: 30.0)
        ])

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.0),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.0),
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 30.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30.0)
        ])

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 70.0),
            button.heightAnchor.constraint(equalToConstant: 30.0),
            button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 100.0),
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            button.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: 0.0)
        ])

        view.backgroundColor = .darkGray
        userNameTextField.backgroundColor = .white
        passwordTextField.backgroundColor = .white
        userNameTextField.placeholder = "User Name"
        passwordTextField.placeholder = "Password"
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        button.backgroundColor = .white
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
    }

    @objc
    func login() {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        viewModel.validateCredentials(credentials: credentials)
    }

    private func setupAccessibilityIdentifiers() {
        userNameTextField.accessibilityIdentifier = "userNameTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        button.accessibilityIdentifier = "button"
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
