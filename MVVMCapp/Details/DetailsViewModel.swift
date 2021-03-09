final public class DetailsViewModel: DetailsViewModelProtocol {
    private struct Constant {
        static let errorTitle: String = "Error"
        static let errorMessage: String = "Backend failure"
        static let errorButtonText: String = "OK"
    }

    private var coordinator: MainCoordinatorProtocol?
    private let apiManager: APIManagerProtocol
    private let sorter: SorterProtocol
    private let merger: MergerProtocol

    init(
        coordinator: MainCoordinatorProtocol?,
        apiManager: APIManagerProtocol,
        sorter: SorterProtocol,
        merger: MergerProtocol
    ) {
        self.coordinator = coordinator
        self.apiManager = apiManager
        self.sorter = sorter
        self.merger = merger
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

    public func sortAndMerge(_ strings: [String], order: SortingOrder, connector: String) -> String {
        let sortedStrings = sorter.sort(strings, order: order)
        return merger.merge(sortedStrings, connector: connector)
    }
}
