import MVVMCapp

final class APIManagerMock: APIManagerProtocol {
    var isLoadStringsSuccessful: Bool = true
    var loadStringsResponse: String = String()
    var loadStringsCallCount: Int = 0
    var loadStringsWasCalled: Bool {
        loadStringsCallCount > 0
    }

    func loadStrings(onSuccess: @escaping ((String) -> Void), onError: @escaping (() -> Void)) {
        loadStringsCallCount += 1
        isLoadStringsSuccessful ?
            onSuccess(loadStringsResponse) :
            onError()
    }
}
