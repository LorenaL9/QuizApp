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
        let logInViewController = LoginViewController(router: self)

        navigationController.pushViewController(logInViewController, animated: false)
        navigationController.navigationBar.isHidden = true
    }

}
