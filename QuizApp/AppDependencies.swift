class AppDependencies {

    lazy var userClient: UserClientProtocol = {
        UserClient()
    }()

    lazy var keychainService: KeychainServiceProtokol = {
        KeychainService()
    }()

}
