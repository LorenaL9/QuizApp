import UIKit

class LoginViewModel {

    @Published var isButtonEnabled = false
    @Published var errorMessage = ""

    private var email: String = ""
    private var password: String = ""

    func emailChanged(emailNew: String) {
        email = emailNew
        activateButton()
    }

    func passwordChanged(passwordNew: String) {
        password = passwordNew
        activateButton()
    }

    @MainActor
    func validateLogin() {
        Task {
            do {
                let token = try await NetworkClient.fetchAccessToken(password: password, username: email)
                print("\(token.accessToken)")
                KeychainService.saveAccessToken(token: token.accessToken, service: "access-token")
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
        if isValidEmail() && isValidPassword() {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
    }

    private func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private func isValidPassword() -> Bool {
        password.count >= 6
    }

}
