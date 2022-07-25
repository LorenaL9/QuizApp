class UserUseCase: UserUseCaseProtocol {

    let keychainService: KeychainServiceProtocol!

    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }

    func logout() {
        keychainService.deleteAccessToken(key: AccessToken.user.rawValue)
    }

}
