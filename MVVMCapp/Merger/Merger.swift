final class Merger: MergerProtocol {
    func merge(_ strings: [String], connector: String) -> String {
        var mergedString = String()
        strings.forEach {
            mergedString.append($0 + connector)
        }
        return mergedString
    }
}
