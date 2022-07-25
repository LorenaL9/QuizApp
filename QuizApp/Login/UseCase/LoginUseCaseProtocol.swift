protocol LoginUseCaseProtocol {

    func login(password: String, username: String) async throws

    func accessTokenIsValid() async throws

}
