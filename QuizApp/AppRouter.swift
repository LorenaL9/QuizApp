import UIKit

protocol AppRouterProtocol {

    func showLogIn()

}

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!
    private let appDependencies: AppDependencies!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.appDependencies = AppDependencies()
    }

    func showLogIn() {
        let viewModel = LoginViewModel(
            router: self,
            userClient: appDependencies.userClient,
            keychainService: appDependencies.keychainService)
        let logInViewController = LoginViewController(viewModel: viewModel)

        navigationController.pushViewController(logInViewController, animated: false)
        navigationController.navigationBar.isHidden = true
    }

}
