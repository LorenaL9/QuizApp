protocol LoginDataSourceProtocol {

    func accessTokenIsValid() async throws

    func login(password: String, username: String) async throws

}
