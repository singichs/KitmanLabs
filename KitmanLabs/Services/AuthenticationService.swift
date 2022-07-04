//
//  AuthenticationService.swift
//  KitmanLabs
//

import Foundation

class AuthenticationService {
    
    enum AuthenticationError: Error {
        case invalidCredentials
    }
    
    func userSignIn(username: String, password: String, completionHandler: @escaping (Result<User, Error>) -> Void) {
        
        let request = constructLoginRequest(username: username, password: password)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                return
            }
            
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(User.self, from: data)
                    completionHandler(.success(results))
                } catch {
                    print("Error: ", error)
                    completionHandler(.failure(AuthenticationError.invalidCredentials))
                }
            }
            
        }
        
        task.resume()
    }
    
    private func constructLoginRequest(username: String, password: String) -> URLRequest {
        let url = URL(string: "https://kml-tech-test.glitch.me/session")
        guard let requestUrl = url else {
            fatalError()
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let body = ["username": username, "password": password]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
        request.httpBody = bodyData
        
        return request
    }
}
