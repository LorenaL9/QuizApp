protocol UserClientProtocol {

    func fetchAccessToken(password: String, username: String) async throws -> LoginResponse

    func checkAccessToken(data: String) async throws

}
