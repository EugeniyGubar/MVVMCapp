import MVVMCapp

final class SorterMock: SorterProtocol {
    var sortAction: (([String], SortingOrder) -> [String]) = { _, _ in return []}
    var sortCallCount: Int = 0
    var sortWasCalled: Bool {
        sortCallCount > 0
    }

    func sort(_ strings: [String], order: SortingOrder) -> [String] {
        sortCallCount += 1
        return sortAction(strings, order)
    }
}
