//
//  NetworkController.swift
//  Koi
//
//  Created by Edgar Mejía on 29/12/21.
//

import Foundation
import Combine

enum HTTP {
    
    enum Method: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
}

struct NetworkController {
    
    func GET(url: URL!, completion: @escaping (Result<Data?, Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(data))
                }
            }
        }
        .resume()
    }
    
}

//struct NetworkController {
//
//    private static let baseUrl = "postman-echo.com"
//
//    enum Endpoint {
//
//        case foo(path: String = "/post")
//
//        var request: URLRequest? {
//            guard let url = url else { return nil }
//            var request = URLRequest(url: url)
//            request.httpMethod = httpMethod
//            request.httpBody = httpBody
//        }
//
//        private var url: URL? {
//            var components = URLComponents()
//
//            components.scheme = "https"
//            components.host = baseUrl
//            components.path = path
//            return components.url
//        }
//
//        private var path: String {
//            switch self {
//            case .foo(let path):
//                return path
//            }
//        }
//
//        private var httpMethod: String {
//            switch self {
//            case .foo:
//                return HTTP.Method.POST.rawValue
//            }
//        }
//
//        private var httpBody: Data? {
//            return try? JSONSerialization.data(withJSONObject: body, options: [])
//        }
//
//    }
//
//}
