import UIKit

class LoginViewModel {

    @Published var isButtonEnabled = false
    @Published var errorMessage = ""

    private var email: String = ""
    private var password: String = ""
    private var router: AppRouterProtocol!
    private var userClient: UserClientProtocol!

    private var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private var isValidPassword: Bool {
        password.count >= 6
    }

    init(router: AppRouterProtocol, userClient: UserClientProtocol) {
        self.router = router
        self.userClient = userClient
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
                print("\(token)")
            } catch {
                errorMessage = "Incorrect email or password"
                print("ERROR: \(error)")
            }
        }
    }

    func getAccessToken() -> Bool {
//        KeychainService.delete(service: "access-token")
        guard
            let data = KeychainService.getAccessToken(service: "access-token")
        else { return false }

        print(data)
        return true
    }

    private func activateButton() {
        let isValid = isValidEmail && isValidPassword
        isButtonEnabled = isValid
    }

}
