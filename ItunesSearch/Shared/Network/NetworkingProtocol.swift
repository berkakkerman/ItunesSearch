//
//  NetworkingProtocol.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import Foundation
import Combine

/// Protocol to which a request dispatcher must conform to.
protocol NetworkingProtocol {
    
    /// Required initializer.
    /// - Parameters:
    ///   - networkSession: Instance conforming to `NetworkSessionProtocol` used for executing requests with a specific configuration.
    init(networkSession: NetworkSessionProtocol)
    
    /// Executes a request.
    /// - Warning: If **endpoint.requestType**  is  **.download**,  **type** should be **URL.self**.
    /// - Parameters:
    ///   - endpoint: Instance conforming to `EndpointProtocol`
    ///   - type: Type of response
    ///   - completion: Completion handler.
    @discardableResult
    func execute<T>(endpoint: EndpointProtocol,
                    decodingType: T.Type,
                    queue: DispatchQueue,
                    retries: Int) -> AnyPublisher<T, Error> where T: Decodable
}

extension NetworkingProtocol {
    
    @discardableResult
    func execute<T>(endpoint: EndpointProtocol,
                    decodingType: T.Type,
                    queue: DispatchQueue = .main,
                    retries: Int = 0) -> AnyPublisher<T, Error> where T: Decodable {
        execute(endpoint: endpoint, decodingType: decodingType, queue: queue, retries: retries)
    }
}

// Class that handles the dispatch of requests to an environment with a given configuration.
class Networking: NetworkingProtocol {
    
    /// The network session configuration.
    private var networkSession: NetworkSessionProtocol
    
    /// Required initializer.
    /// - Parameters:
    ///   - networkSession: Instance conforming to `NetworkSessionProtocol` used for executing requests with a specific configuration.
    required init(networkSession: NetworkSessionProtocol) {
        self.networkSession = networkSession
    }
    
    /// Makes network call
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - decodingType: Response decoding type.
    ///   - queue: DispatchQueue. Defaults main.
    ///   - retries: Retry count
    @discardableResult
    func execute<T>(endpoint: EndpointProtocol,
                    decodingType: T.Type,
                    queue: DispatchQueue = .main,
                    retries: Int = 0) -> AnyPublisher<T, Error> where T: Decodable {
        
        // Create a URL request.
        guard let urlRequest = endpoint.urlRequest, let session = networkSession.session else {
            return Fail(error: NetworkError.badRequest(0, ""))
                .eraseToAnyPublisher()
        }
        
        Logger.debug("REQUEST URL: \(urlRequest.url?.absoluteString ?? "-")")
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap {
                
                Logger.debug("STATUS CODE: \(String(describing: ($0.response as? HTTPURLResponse)?.statusCode ?? 0))")
                
                if let json = try? JSONSerialization.jsonObject(with: $0.data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                    Logger.debug("RESPONSE: \n \(String(decoding: jsonData, as: UTF8.self))")
                } else {
                    Logger.error("JSON data malformed!")
                }
                
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.invalidResponse
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()
    }
}

// MARK: - Handle
private extension Networking {
    
    /// Handles the data response that is expected as a JSON object output.
    /// - Parameters:
    ///   - data: The `Data` instance to be serialized into a JSON object.
    ///   - urlResponse: The received  optional `URLResponse` instance.
    ///   - error: The received  optional `Error` instance.
    ///   - completion: Completion handler.
    private func handleJsonTaskResponse<T: Decodable>(data: Data?, urlResponse: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        // Check if the response is valid.
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            completion(.failure(NetworkError.invalidResponse))
            return
        }
        // Verify the HTTP status code.
        let result = verify(data: data, urlResponse: urlResponse, error: error)
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(decoded))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}


// MARK: - Util
private extension Networking {
    
    /// Checks if the HTTP status code is valid and returns an error otherwise.
    /// - Parameters:
    ///   - data: The data or file  URL .
    ///   - urlResponse: The received  optional `URLResponse` instance.
    ///   - error: The received  optional `Error` instance.
    /// - Returns: A `Result` instance.
    private func verify<T>(data: T?, urlResponse: HTTPURLResponse, error: Error?) -> Result<T, Error> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(NetworkError.noData)
            }
        case 400...499:
            return .failure(NetworkError.badRequest(urlResponse.statusCode, error?.localizedDescription))
        case 500...599:
            return .failure(NetworkError.serverError(urlResponse.statusCode, error?.localizedDescription))
        default:
            return .failure(NetworkError.unknown(error?.localizedDescription))
        }
    }
}
