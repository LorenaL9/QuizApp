class AppDependencies {

    lazy var userClient: UserClientProtocol = {
        UserClient()
    }()

}
