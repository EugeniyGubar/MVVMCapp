public struct Credentials {
    let userName: String
    let password: String
}

final class Validator: ValidatorProtocol {
    private struct Constant {
        static let validUsername: String = "user"
        static let validPassword: String = "123qwe"
    }

    func isValid(credentials: Credentials) -> Bool {
        credentials.userName == Constant.validUsername &&
            credentials.password == Constant.validPassword
    }
}
