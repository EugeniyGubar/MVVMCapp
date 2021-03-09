public enum SortingOrder: Int, CaseIterable {
    case asIs = 0
    case ascending
    case descending

    var title: String {
        switch self {
        case .asIs:
            return "As Is"
        case .ascending:
            return "A-Z"
        case .descending:
            return "Z-A"
        }
    }
}

final class Sorter: SorterProtocol {
    func sort(_ strings: [String], order: SortingOrder) -> [String] {
        switch order {
        case .ascending:
            return strings.sorted { $0.lowercased() < $1.lowercased() }
        case .descending:
            return strings.sorted { $0.lowercased() > $1.lowercased() }
        case .asIs:
            return strings
        }
    }
}
