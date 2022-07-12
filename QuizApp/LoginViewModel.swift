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

    func validateLogin() async {
        do {
            let token = try await NetworkClient.accessToken(password: password, username: email)
            print("\(token)")
        } catch {
            errorMessage = "Incorrect email or password"
            print("ERROR: \(error)")
        }
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
        password.count >= 8
    }

}
