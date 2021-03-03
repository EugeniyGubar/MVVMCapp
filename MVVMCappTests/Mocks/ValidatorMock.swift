import MVVMCapp

final class ValidatorMock: ValidatorProtocol {
    var isValidAction: ((Credentials) -> Bool) = { _ in true }
    var isValidCallCount: Int = 0
    var isValidWasCalled: Bool {
        isValidCallCount > 0
    }

    func isValid(credentials: Credentials) -> Bool {
        isValidCallCount += 1
        return isValidAction(credentials)
    }
}
