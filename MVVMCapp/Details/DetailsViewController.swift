import UIKit

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private let segmentedControl: UISegmentedControl = UISegmentedControl(items: SortingOrder.allCases.map { $0.title })
    let textView: UITextView = UITextView()

    private var viewModel: DetailsViewModelProtocol
    private var receivedStrings: [String] = []

    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.addSubview(segmentedControl)
        view.addSubview(activityIndicator)
        view.addSubview(textView)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30.0),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.backgroundColor = .darkGray
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .lightGray
        segmentedControl.addTarget(self, action: #selector(changeOrder(sender:)), for: .valueChanged)
        activityIndicator.color = .white
        textView.backgroundColor = .darkGray
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 20.0)
        textView.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchData()
    }

    @objc
    private func changeOrder(sender: UISegmentedControl) {
        updateText()
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

    private func updateText() {
        let sortedMergedString = viewModel.sortAndMerge(
            receivedStrings,
            order: SortingOrder(rawValue: segmentedControl.selectedSegmentIndex) ?? .asIs,
            connector: "\n"
        )
        textView.text = sortedMergedString
    }

    private func fetchData() {
        showActivityIndicator()
        viewModel.fetchData(
            onSuccess: { [weak self] responseString in
                self?.receivedStrings.removeAll()
                responseString.enumerateLines(invoking: {
                    line, _ in
                    self?.receivedStrings.append(line)
                })
                self?.hideActivityIndicator()
                self?.showTextView()
                self?.updateText()
            },
            onError: { [weak self] in
                self?.hideActivityIndicator()
            })
    }

    private func setupAccessibilityIdentifiers() {
        segmentedControl.accessibilityIdentifier = "segmentedControl"
        textView.accessibilityIdentifier = "textView"
        activityIndicator.accessibilityIdentifier = "activityIndicator"
    }
}
