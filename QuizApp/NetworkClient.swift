import UIKit

enum RequestError: Error {

    case clientError
    case invalidURL
    case serverError
    case noDataError
    case dataDecodingError
}

class NetworkClient {

    static func accessToken(password: String, username: String) async throws -> LoginResponse {
        guard
            let url = URL(string: "https://five-ios-quiz-app.herokuapp.com/api/v1/login")
        else { throw RequestError.invalidURL }

        let postString = "password=\(password)&username=\(username)"
        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard
            let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            throw RequestError.serverError
        }

        guard
            let result = try? JSONDecoder().decode(LoginResponse.self, from: data)
        else { throw RequestError.dataDecodingError }

        return result
    }

}
