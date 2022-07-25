import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        let appDependencies = AppDependencies()
        let router = AppRouter(navigationController: navigationController, appDependencies: appDependencies)

        window = UIWindow(windowScene: windowScene)

        Task {
            do {
                try await appDependencies.loginUseCase.accessTokenIsValid()
                router.showHomePage()
            } catch {
                router.showLogIn()
            }
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
