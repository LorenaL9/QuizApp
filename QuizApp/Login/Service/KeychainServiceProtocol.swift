protocol KeychainServiceProtokol {

    func saveAccessToken(token: String, key: String)

    func getAccessToken(key: String) -> String?

    func deleteAccessToken(key: String)

}
