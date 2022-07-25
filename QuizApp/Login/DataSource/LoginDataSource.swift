import Foundation

class LogindataSource: LoginDataSourceProtocol {

    let userClient: UserClientProtocol!
    let keychainService: KeychainServiceProtocol!

    init(userClient: UserClientProtocol, keychainService: KeychainServiceProtocol) {
        self.userClient = userClient
        self.keychainService = keychainService
    }

    func login(password: String, username: String) async throws {
        guard
            let token = try? await userClient.fetchAccessToken(password: password, username: username)
        else {
            throw TokenError.noAccessToken
        }

        keychainService.saveAccessToken(token: token.accessToken, key: AccessToken.user.rawValue)
    }

    func accessTokenIsValid() async throws {
        guard
            let token: String = keychainService.getAccessToken(key: AccessToken.user.rawValue)
        else {
            throw TokenError.noAccessToken
        }

        do {
            try await userClient.checkAccessToken(data: token)
        } catch {
            throw TokenError.noValidAccessToken
        }
    }

}
