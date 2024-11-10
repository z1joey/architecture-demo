import Foundation
import Security

func validateCertificate(serverTrust: SecTrust, domain: String?) -> Bool {
    let policy = SecPolicyCreateSSL(true, domain as CFString?)
    SecTrustSetPolicies(serverTrust, policy)

    let status = SecTrustEvaluateWithError(serverTrust, nil)
    return status
}

func setSecureCookie() {
    let cookieProperties: [HTTPCookiePropertyKey: Any] = [
        .domain: "example.com",
        .path: "/",
        .name: "sessionToken",
        .value: "secureToken",
        .secure: true,
        .expires: Date().addingTimeInterval(3600)
    ]

    if let cookie = HTTPCookie(properties: cookieProperties) {
        HTTPCookieStorage.shared.setCookie(cookie)
    }
}

func writeSecureData() {
    let data = "Sensitive Data".data(using: .utf8)!
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/secure.txt"
    try? data.write(to: URL(fileURLWithPath: filePath), options: .completeFileProtection)
}

import AuthenticationServices

class OAuthManager: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        guard let window = UIApplication.shared.connectedScenes.compactMap({ $0.delegate as? SceneDelegate }).first?.window else {
            fatalError()
        }

        return window
    }

    func authenticate() {
        let authURL = URL(string: "https://example.com/auth")!
        let callbackURLScheme = "myapp"

        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: callbackURLScheme) { callbackURL, error in
            // Handle authentication
        }

        session.presentationContextProvider = self
        session.start()
    }
}
