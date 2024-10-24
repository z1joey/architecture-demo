import XCTest
@testable import MVVM

final class EntranceTests: XCTestCase {
    
    let expectation = XCTestExpectation()
    var viewModel: EntranceView.ViewModel?
    var expectedName: String?

    override func setUp() {
        viewModel = .init(
            deeplinks: [AnyDeeplink(url: URL(string: "demo://users/test")!)],
            showUserView: { [unowned self] name in
                self.expectedName = name
                self.expectation.fulfill()
            }
        )
    }

    func test_entrance_showUser() {
        let testName = "testName"
        viewModel?.userName = testName
        viewModel?.showUser()
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(expectedName)
        XCTAssertEqual(expectedName, testName)
    }
}
