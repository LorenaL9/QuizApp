import UIKit

protocol AppRouterProtocol {

    func showLogIn()

}

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogIn() {
        let viewModel = LoginViewModel(router: self)
        let logInViewController = LoginViewController(viewModel: viewModel)

        navigationController.pushViewController(logInViewController, animated: false)
        navigationController.navigationBar.isHidden = true
    }

}
