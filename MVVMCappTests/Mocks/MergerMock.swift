import MVVMCapp

final class MergerMock: MergerProtocol {
    var mergeAction: (([String], String) -> String) = { _, _ in return String()}
    var mergeCallCount: Int = 0
    var mergeWasCalled: Bool {
        mergeCallCount > 0
    }

    func merge(_ strings: [String], connector: String) -> String {
        mergeCallCount += 1
        return mergeAction(strings, connector)
    }
}
