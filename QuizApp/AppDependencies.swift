import Keychain

class AppDependencies {

    lazy var userClient: UserClientProtocol = {
        UserClient()
    }()

    lazy var keychainService: KeychainServiceProtokol = {
        let keychain = Keychain()

        return KeychainService(keychain: keychain)
    }()

}
