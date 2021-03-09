import XCTest
@testable import MVVMCapp

class DetailsTests: XCTestCase {
    private var apiManagerMock: APIManagerMock!
    private var coordinatorMock: CoordinatorMock!
    private var sorterMock: SorterMock!
    private var mergerMock: MergerMock!
    private var detailsViewModel: DetailsViewModelProtocol!

    override func setUp() {
        super.setUp()

        apiManagerMock = APIManagerMock()
        coordinatorMock = CoordinatorMock()
        sorterMock = SorterMock()
        mergerMock = MergerMock()
        detailsViewModel = DetailsViewModel(
            coordinator: coordinatorMock,
            apiManager: apiManagerMock,
            sorter: sorterMock,
            merger: mergerMock
        )
    }

    override func tearDown() {
        apiManagerMock = nil
        coordinatorMock = nil
        detailsViewModel = nil

        super.tearDown()
    }

    func testFetchDataSuccess() {
        detailsViewModel.fetchData(
            onSuccess: { _ in },
            onError: {}
        )

        XCTAssert(apiManagerMock.loadStringsWasCalled)
        XCTAssert(apiManagerMock.loadStringsCallCount == 1)

        XCTAssert(!sorterMock.sortWasCalled)
        XCTAssert(sorterMock.sortCallCount == 0)
        XCTAssert(!mergerMock.mergeWasCalled)
        XCTAssert(mergerMock.mergeCallCount == 0)
    }

    func testFetchDataFailure() {
        apiManagerMock.isLoadStringsSuccessful = false
        detailsViewModel.fetchData(
            onSuccess: { _ in },
            onError: {}
        )

        XCTAssert(apiManagerMock.loadStringsWasCalled)
        XCTAssert(apiManagerMock.loadStringsCallCount == 1)

        XCTAssert(!sorterMock.sortWasCalled)
        XCTAssert(sorterMock.sortCallCount == 0)
        XCTAssert(!mergerMock.mergeWasCalled)
        XCTAssert(mergerMock.mergeCallCount == 0)

        XCTAssert(coordinatorMock.showAlertWasCalled)
        XCTAssert(coordinatorMock.showAlertCallCount == 1)
    }

    func testSortAndMergeWasCalled() {
        _ = detailsViewModel.sortAndMerge(["a", "b", "c"], order: .descending, connector: "-")

        XCTAssert(!apiManagerMock.loadStringsWasCalled)
        XCTAssert(apiManagerMock.loadStringsCallCount == 0)

        XCTAssert(sorterMock.sortWasCalled)
        XCTAssert(sorterMock.sortCallCount == 1)
        XCTAssert(mergerMock.mergeWasCalled)
        XCTAssert(mergerMock.mergeCallCount == 1)
    }
}
