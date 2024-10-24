import XCTest
import Combine
import DataAccess

@testable import MVVM

final class UserTests: XCTestCase {
    var cancelBag = Set<AnyCancellable>()
    var viewModel: UserView.ViewModel?
    var provider: GitHubUserProviderProtocol = MockedUserProvider()
    let testUser = "testUser"

    override func setUp() {
        viewModel = .init(
            user: testUser,
            userProvider: provider
        )
    }

    func test_user_provider() async throws {
        let expectation = XCTestExpectation()
        var user: GitHubUser?
        var storedError: Error?

        do {
            user = try await provider.fetch(user: testUser)
            expectation.fulfill()
        } catch {
            storedError = error
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(user?.login, mockedUser.login)
        XCTAssertEqual(user?.avatarUrl, mockedUser.avatarUrl)
        XCTAssertEqual(user?.bio, mockedUser.bio)
        XCTAssertNil(storedError)
    }

    func test_user_request() {
        let expectation = XCTestExpectation()
        XCTAssertEqual(viewModel?.user, testUser)

        viewModel?.$gitHubUser
            .dropFirst()
            .sink(receiveValue: {
                XCTAssertNotNil($0)
                XCTAssertEqual($0?.login, mockedUser.login)
                XCTAssertEqual($0?.avatarUrl, mockedUser.avatarUrl)
                XCTAssertEqual($0?.bio, mockedUser.bio)
                expectation.fulfill()
            })
            .store(in: &cancelBag)

        viewModel?.request()
        wait(for: [expectation], timeout: 1)
    }
}
