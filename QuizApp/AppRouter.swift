import UIKit

protocol AppRouterProtocol {

    func showLogIn()

    func showUserViewController()

}

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!
    private let appDependencies: AppDependencies!

    init(navigationController: UINavigationController, appDependencies: AppDependencies) {
        self.navigationController = navigationController
        self.appDependencies = appDependencies
    }

    func showLogIn() {
        let viewModel = LoginViewModel(router: self, loginUseCase: appDependencies.loginUseCase)
        let logInViewController = LoginViewController(viewModel: viewModel)

        navigationController.pushViewController(logInViewController, animated: false)
        navigationController.navigationBar.isHidden = true
    }

    func showUserViewController() {
        let userViewController = UserViewController()

        navigationController.pushViewController(userViewController, animated: true)
        navigationController.navigationBar.isHidden = true
    }

}
