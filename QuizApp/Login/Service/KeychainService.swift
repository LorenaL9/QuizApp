import UIKit
import Keychain

class KeychainService: KeychainServiceProtokol {

    let keychain: Keychain!

    init() {
        keychain = Keychain()
    }

    func saveAccessToken(token: String, key: String) {
        let saved = keychain.save(token, forKey: key)
        print("Token is saved: \(saved)")
    }

    func getAccessToken(key: String) -> String? {
        let value = keychain.value(forKey: key)

        return value as? String
    }

    func deleteAccessToken(key: String) {
        let deleted = keychain.remove(forKey: key)

        print("Access token deleted: \(deleted)")
    }

}
