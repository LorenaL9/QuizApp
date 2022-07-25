import UIKit
import Keychain

class KeychainService: KeychainServiceProtocol {

    let keychain: Keychain!

    init(keychain: Keychain) {
        self.keychain = keychain
    }

    func saveAccessToken(token: String, key: String) {
        keychain.save(token, forKey: key)
    }

    func getAccessToken(key: String) -> String? {
        keychain.value(forKey: key) as? String
    }

    func deleteAccessToken(key: String) {
        keychain.remove(forKey: key)
    }

}
