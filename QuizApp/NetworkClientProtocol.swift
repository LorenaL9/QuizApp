protocol NetworkClientProtocol {

    static func fetchAccessToken(password: String, username: String) async throws -> LoginResponse

}
