import UIKit
import Security

class KeychainService {

    static func saveAccessToken(token: String, service: String) {
        let keychainItemQuery = [
            kSecValueData: token.data(using: .utf8)!,
            kSecAttrService: service,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary

        let status = SecItemAdd(keychainItemQuery, nil)
        print("Operation finished with status: \(status)")
    }

    static func getAccessToken(service: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        return (result as? Data)
    }

    static func delete(service: String) {
        let query = [
          kSecClass: kSecClassGenericPassword,
          kSecAttrService: service
        ] as CFDictionary

        SecItemDelete(query)
    }

}
