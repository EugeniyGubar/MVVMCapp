import XCTest
@testable import MVVMCapp

class DetailsTests: XCTestCase {
    private var apiManagerMock: APIManagerMock!
    private var coordinatorMock: CoordinatorMock!
    private var detailsViewModel: DetailsViewModelProtocol!

    override func setUp() {
        super.setUp()

        apiManagerMock = APIManagerMock()
        coordinatorMock = CoordinatorMock()
        detailsViewModel = DetailsViewModel(
            coordinator: coordinatorMock,
            apiManager: apiManagerMock
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
    }

    func testFetchDataFailure() {
        apiManagerMock.isLoadStringsSuccessful = false
        detailsViewModel.fetchData(
            onSuccess: { _ in },
            onError: {}
        )

        XCTAssert(apiManagerMock.loadStringsWasCalled)
        XCTAssert(apiManagerMock.loadStringsCallCount == 1)

        XCTAssert(coordinatorMock.showAlertWasCalled)
        XCTAssert(coordinatorMock.showAlertCallCount == 1)
    }
}
