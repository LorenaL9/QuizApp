import UIKit

class UserClient: UserClientProtocol {

    func fetchAccessToken(password: String, username: String) async throws -> LoginResponse {
        guard
            let url = URL(string: "https://five-ios-quiz-app.herokuapp.com/api/v1/login/")
        else {
            throw RequestError.invalidURL
        }

        let json = ["password": password, "username": username]
        let jsonData = try JSONSerialization.data(withJSONObject: json)

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)

        guard
            let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            throw RequestError.clientError
        }

        guard
            let result = try? JSONDecoder().decode(LoginResponse.self, from: data)
        else {
            throw RequestError.dataDecodingError
        }

        return result
    }

    func checkAccessToken(data: String) async throws {
        guard
            let url = URL(string: "https://five-ios-quiz-app.herokuapp.com/api/v1/check/")
        else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)

        request.setValue("Bearer \(data)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let (_, response) = try await URLSession.shared.data(for: request)

        guard
            let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            throw RequestError.clientError
        }
    }

}
