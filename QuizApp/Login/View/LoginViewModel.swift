import UIKit

class LoginViewModel {

    @Published var isButtonEnabled = false
    @Published var errorMessage = ""

    private var email: String = ""
    private var password: String = ""
    private var router: AppRouterProtocol!
    private var loginUseCase: LoginUseCaseProtocol!

    private var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private var isValidPassword: Bool {
        password.count >= 6
    }

    init(router: AppRouterProtocol, loginUseCase: LoginUseCaseProtocol) {
        self.router = router
        self.loginUseCase = loginUseCase
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
                try await loginUseCase.login(password: password, username: email)
                router.showHomePage()
            } catch {
                errorMessage = "Incorrect email or password"
                print(error)
            }
        }
    }

    private func activateButton() {
        let isValid = isValidEmail && isValidPassword
        isButtonEnabled = isValid
    }

}
