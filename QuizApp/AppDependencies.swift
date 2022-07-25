import Keychain

class AppDependencies {

    lazy var userClient: UserClientProtocol = {
        UserClient()
    }()

    lazy var keychainService: KeychainServiceProtocol = {
        let keychain = Keychain()

        return KeychainService(keychain: keychain)
    }()

    lazy var loginDataSource: LoginDataSourceProtocol = {
        LogindataSource(userClient: userClient, keychainService: keychainService)
    }()

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(loginDataSource: loginDataSource)
    }()

}
