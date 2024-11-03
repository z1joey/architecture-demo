import Combine
import SwiftUI
import Foundation

enum DeepLink: Equatable {
    case showProfile(user: String)
    
    init?(url: URL) {
        guard let components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        ),
              components.host == "viper.com",
              let query = components.queryItems else {
            return nil
        }

        if let item = query.first(where: { $0.name == "userName" }),
            let userName = item.value {
            self = .showProfile(user: userName)
            return
        }
        return nil
    }
}

class DeeplinkWorkFlow {
    let userDidSignIn: AnyPublisher<Bool, Never>
    var didReceiveDeeplink: AnyPublisher<URL, Never>

    private var cancellable: Cancellable? = nil

    init(userDidSignIn: AnyPublisher<Bool, Never>,
         didReceiveDeeplink: AnyPublisher<URL, Never>) {
        self.userDidSignIn = userDidSignIn
        self.didReceiveDeeplink = didReceiveDeeplink
    }

    func commit() {
        
        cancellable = Publishers
            .CombineLatest(userDidSignIn, didReceiveDeeplink)
            .flatMap { (isSuccess, url) -> Future<DeepLink, Error> in
                Future { promise in
                    if isSuccess, let link = DeepLink(url: url) {
                        promise(.success(link))
                    }

                    promise(.failure(NSError(domain: url.absoluteString, code: 0)))
                }
            }
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { deepLink in
                print(deepLink)
            })
    }
}
