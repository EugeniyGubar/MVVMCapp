import UIKit

protocol DetailsViewControllerProtocol: UIViewController {

}

public protocol DetailsViewModelProtocol {
    func fetchData(onSuccess: @escaping ((String) -> Void), onError: @escaping (() -> Void))
    func sortAndMerge(_ strings: [String], order: SortingOrder, connector: String) -> String
}
