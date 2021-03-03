public protocol ValidatorProtocol {
    func isValid(credentials: Credentials) -> Bool
}
