import Foundation

class LogindataSource {

    let userClient: UserClientProtocol!

    init(userClient: UserClientProtocol) {
        self.userClient = userClient
    }

    func getAccessToken(password: String, username: String) async throws -> LoginData {
        guard
            let token = try? await userClient.fetchAccessToken(password: password, username: username)
        else { throw TokenError.noAccessToken}

        return LoginData(accessToken: token.accessToken)
    }

    func accessTokenIsValid(token: String) async throws {
        try await userClient.checkAccessToken(data: token)
    }

}
