import XCTest
import SwiftUI
import Combine
@testable import MVVM
@testable import DataAccess

final class CoordinatorTests: XCTestCase {
    var coordinator: Coordinator = .init()
    var cancelBag = Set<AnyCancellable>()

    override func setUp() {
        coordinator = .init()
    }

    func test_coordinator_showUser() {
        let expectation = XCTestExpectation()

        coordinator.$navigationPath
            .dropFirst()
            .sink {
                XCTAssertEqual($0.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancelBag)

        coordinator.showUser("newUser")

        wait(for: [expectation], timeout: 1)
    }

    func test_coordinator_showRoot() {
        let expectation = XCTestExpectation()

        coordinator.$navigationPath
            .dropFirst()
            .sink {
                XCTAssertEqual($0.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancelBag)

        coordinator.showRoot()

        wait(for: [expectation], timeout: 1)
    }

    func test_coordinator_showError() throws {
        let expectation = XCTestExpectation()

        coordinator.$error
            .dropFirst()
            .sink(receiveValue: {
                XCTAssertNotNil($0)
                XCTAssertTrue($0 is GitHubError)
                expectation.fulfill()
            })
            .store(in: &cancelBag)

        coordinator.showError(GitHubError.invalidData)

        wait(for: [expectation], timeout: 1)
    }
}
