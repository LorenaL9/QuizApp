protocol UserClientProtocol {

    func fetchAccessToken(password: String, username: String) async throws -> LoginResponse

}
