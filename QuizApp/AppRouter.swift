import UIKit

protocol AppRouterProtocol {

    func showLogIn()

    func showHomePage()

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

    func showHomePage() {
        let quizViewController = QuizViewController()
        quizViewController.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "quizSelected"), tag: 0)

        let userViewModel = UserViewModel(router: self, userUseCase: appDependencies.userUseCase)
        let userViewController = UserViewController(viewModel: userViewModel)
        userViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "Settings"), tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [quizViewController, userViewController]
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1)

        navigationController.pushViewController(tabBarController, animated: false)
    }

}
