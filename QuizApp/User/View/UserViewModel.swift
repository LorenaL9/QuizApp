import UIKit

class UserViewModel {

    private var router: AppRouterProtocol!
    private var userUseCase: UserUseCaseProtocol!

    init(router: AppRouterProtocol, userUseCase: UserUseCaseProtocol) {
        self.router = router
        self.userUseCase = userUseCase
    }

    func logout() {
        userUseCase.logout()
        router.showLogIn()
    }

}
