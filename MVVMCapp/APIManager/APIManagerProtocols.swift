public protocol APIManagerProtocol {
    func loadStrings(onSuccess: @escaping ((String) -> Void), onError: @escaping (() -> Void))
}
