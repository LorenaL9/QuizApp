import UIKit

class LoginViewModel {

    @Published var isButtonEnabled = false
    @Published var errorMessage = ""

    private var email: String = ""
    private var password: String = ""
    private var router: AppRouterProtocol!
    private var userClient: UserClientProtocol!
    private var keychainService: KeychainServiceProtokol!

    private var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private var isValidPassword: Bool {
        password.count >= 6
    }

    init(router: AppRouterProtocol, userClient: UserClientProtocol, keychainService: KeychainServiceProtokol) {
        self.router = router
        self.userClient = userClient
        self.keychainService = keychainService
    }

    func emailChanged(newEmail: String) {
        email = newEmail
        activateButton()
    }

    func passwordChanged(newPassword: String) {
        password = newPassword
        activateButton()
    }

    @MainActor
    func validateLogin() {
        Task {
            do {
                let token = try await userClient.fetchAccessToken(password: password, username: email)
                keychainService.saveAccessToken(token: token.accessToken, key: AccessToken.user.rawValue)
            } catch {
                errorMessage = "Incorrect email or password"
                print("ERROR: \(error)")
            }
        }
    }

    func getAccessToken() -> Bool {
        let data = keychainService.getAccessToken(key: AccessToken.user.rawValue)
        return data != nil
    }

    private func activateButton() {
        let isValid = isValidEmail && isValidPassword
        isButtonEnabled = isValid
    }

}
