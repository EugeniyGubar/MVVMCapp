final public class DetailsViewModel: DetailsViewModelProtocol {
    private struct Constant {
        static let errorTitle: String = "Error"
        static let errorMessage: String = "Backend failure"
        static let errorButtonText: String = "OK"
    }

    private var coordinator: MainCoordinatorProtocol?
    private let apiManager: APIManagerProtocol

    init(coordinator: MainCoordinatorProtocol?, apiManager: APIManagerProtocol) {
        self.coordinator = coordinator
        self.apiManager = apiManager
    }

    public func fetchData(onSuccess: @escaping ((String) -> Void), onError: @escaping (() -> Void)) {
        apiManager.loadStrings(
            onSuccess: { responseString in
                onSuccess(responseString)
            },
            onError: { [weak self] in
                onError()
                self?.coordinator?.showAlert(
                    title: Constant.errorTitle,
                    message: Constant.errorMessage,
                    buttonText: Constant.errorButtonText
                )
            }
        )
    }
}
