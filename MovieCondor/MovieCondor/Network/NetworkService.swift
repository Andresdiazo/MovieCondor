//
//  NetworkService.swift
//  MovieCondor
//
//  Created by leonard Borrego on 1/06/22.
//

import Foundation
import Combine

typealias parameters = [String: Any]

enum Result: Error {
    case success(Dictionary<String, Any>)
    case failure(ErrorRequest)
}

enum HTTPMethod: String {
    case get        = "GET"
    case post       = "POST"
    case connect    = "CONNECT"
    case delete     = "DELETE"
    case put        = "PUT"
}


enum ErrorRequest: Error {
    case connectionError(message: String)
    case unknownError(message: String)
    case authorizationError(message: String, Data)
    case serverError(message: String)
    case jsonError(message: String)
}

public class NetworkService {
    private var baseURL: URL?
    private var apiKey: String = "28490dbb804ee88422a684e67782b2db"
    
    static var shared: NetworkService = NetworkService()
    
    func getApiKey() -> String {
        return apiKey
    }
    
    func consumeService(baseUrl: String,
                        method: HTTPMethod = .get,
                        parameters: parameters? = nil,
                        completion: @escaping (Result) -> Void){
        
        let header = ["Content-Type" : "application/json; charset=utf-8"]
        
        var request = URLRequest(url: URL(string: baseUrl)!,
                                 timeoutInterval: 10)
        request.allHTTPHeaderFields = header
        request.httpMethod = method.rawValue
        do {
            if let dic = parameters {
                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                request.httpBody = jsonData
            }
        } catch {
            
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                do {
                    if let error = error {
                        print(error)
                        completion(Result.failure(.connectionError(message: error.localizedDescription)))
                    } else if let data = data, let responseCode = response as? HTTPURLResponse {
                        switch responseCode.statusCode {
                        case 200:
                            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any> {
                                completion(Result.success(convertedJsonIntoDict))
                            }
                        case 400...499:
                            completion(Result.failure(.authorizationError(message: responseCode.description ,data)))
                        case 500...599:
                            completion(Result.failure(.serverError(message: responseCode.description)))
                        default:
                            completion(Result.failure(.unknownError(message: responseCode.description)))
                            break
                        }
                    }
                } catch {
                    
                }
            }
        }.resume()
    }
    
    static func cancel() {
        URLSession.shared.invalidateAndCancel()
    }
}
