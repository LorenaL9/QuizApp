class LoginUseCase: LoginUseCaseProtocol {

    let loginDataSource: LoginDataSourceProtocol!

    init(loginDataSource: LoginDataSourceProtocol) {
        self.loginDataSource = loginDataSource
    }

    func login(password: String, username: String) async throws {
        do {
            try await loginDataSource.login(password: password, username: username)
        } catch {
            throw error
        }
    }

    func accessTokenIsValid() async throws {
        do {
            try await loginDataSource.accessTokenIsValid()
        } catch {
            throw error
        }
    }

}
