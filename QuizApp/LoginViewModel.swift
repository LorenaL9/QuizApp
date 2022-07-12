import UIKit

class LoginViewModel {

    @Published var isButtonEnabled = false
    @Published var errorMessage = ""

    private var email: String = ""
    private var password: String = ""

    func emailChanged(newEmail: String) {
        email = newEmail
        activateButton()
    }

    func passwordChanged(newPassword: String) {
        password = newPassword
        activateButton()
    }

    func validateLogin() {
        errorMessage = "Incorrect email or password"
    }

    private func activateButton() {
        let isValid = getEmailValidation() && getPasswordValidatioon()
        isButtonEnabled = isValid ? true : false
    }

    private func getEmailValidation() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private func getPasswordValidatioon() -> Bool {
        password.count >= 8
    }

}
