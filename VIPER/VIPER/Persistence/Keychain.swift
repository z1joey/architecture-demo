import Security
import Foundation

protocol KeychainGateway {
    func store(key: String, value: String)
    func retrieve(key: String) -> String?
}

struct Keychain: KeychainGateway {
    private let semaphore: DispatchSemaphore = DispatchSemaphore(value: 1)

    func store(key: String, value: String) {
        defer {
            semaphore.signal()
        }

        semaphore.wait()
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: value.data(using: .utf8)!
        ]
        SecItemAdd(query as CFDictionary, nil)
    }

    func retrieve(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let data = item as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }
}
