import UIKit

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    let textView: UITextView = UITextView()

    private var viewModel: DetailsViewModelProtocol

    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.addSubview(activityIndicator)
        view.addSubview(textView)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.backgroundColor = .darkGray
        activityIndicator.color = .white
        textView.backgroundColor = .darkGray
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 20.0)
        textView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchData()
    }

    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }

    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    private func showTextView() {
        textView.isHidden = false
    }

    private func setText(_ text: String) {
        textView.text = text
    }

    private func fetchData() {
        showActivityIndicator()
        viewModel.fetchData(
            onSuccess: { [weak self] responseString in
                self?.hideActivityIndicator()
                self?.showTextView()
                self?.setText(responseString)
            },
            onError: { [weak self] in
                self?.hideActivityIndicator()
            })
    }
}
