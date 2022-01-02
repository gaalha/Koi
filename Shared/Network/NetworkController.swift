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
    
    enum Header {
        
        enum Field: String {
            case contentType = "Content-Type"
        }
        
        enum Value: String {
            case json = "application/json"
            case text = "text/plain"
            case multipart = "multipart/form-data"
        }
        
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
    
    func POST(url: String, data: Data?, completion: @escaping (Result<Data?, Error>) -> ()) {
        guard let url = URL(string: url)
        else { return }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HTTP.Method.POST.rawValue
        request.setValue(HTTP.Header.Value.multipart.rawValue, forHTTPHeaderField: HTTP.Header.Field.contentType.rawValue)
        request.httpBody = createMultipartBody(data: data!, file: "multipartData")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                }
                
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(data))
                }
            }
        }
        .resume()
    }
    
    func createMultipartBody(data: Data, boundary: String = "Boundary-\("562F49C8-26CD-4D87-9C8F-DEA380DE4BF007")", file: String) -> Data {
        let body = NSMutableData()
        let lineBreak = "\r\n"
        let boundaryPrefix = "--\(boundary)\r\n"
        body.appendString(string: boundaryPrefix)
        body.appendString(string: "Content-Disposition: form-data; name=\"\(file)\"\r\n")
        body.appendString(string: "Content-Type: \("application/json;charset=utf-8")\r\n\r\n")
        body.append(data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\(lineBreak)")
        return body as Data
    }
    
}

extension NSMutableData {

    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    public func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
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
