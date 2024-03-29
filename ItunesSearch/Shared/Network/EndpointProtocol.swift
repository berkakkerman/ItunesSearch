//
//  EndPoint.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import Foundation

/// Protocol to which the HTTP requests must conform.
protocol EndpointProtocol {
    
    /// The base URL of the environment.
    var baseURL: String { get }
    
    /// The path that will be appended to API's base URL.
    var path: String { get }
    
    /// The HTTP method.
    var method: RequestMethod { get }
    
    /// The HTTP headers/
    var headers: ReaquestHeaders? { get }
    
    /// The query parameters.
    var parameters: RequestParameters? { get }
    
    /// The HTTP body.
    var body: Encodable? { get }
}

// MARK: - UrlRequest
extension EndpointProtocol {
    
    /// Returns: An optional `URLRequest`
    public var urlRequest: URLRequest? {
        // Create the base URL.
        guard let url = url else {
            return nil
        }
        // Create a request with that URL.
        var request = URLRequest(url: url)
        
        // Append all related properties.
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body?.jsonData
        
        return request
    }
    
    /// Creates a URL with the given base URL.
    /// - Parameter baseURL: The base URL string.
    /// - Returns: An optional `URL`.
    private var url: URL? {
        // Create a URLComponents instance to compose the url.
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        // Add the request path to the existing base URL path
        urlComponents.path = urlComponents.path + path
        // Add query items to the request URL
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    /// Returns the URLRequest `URLQueryItem`
    private var queryItems: [URLQueryItem] {
        guard let parameters = parameters else {
            return []
        }
        // Convert parameters to query items.
        return parameters.map { (key: String, value: String) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }
    }
}

/// HTTP request methods.
enum RequestMethod: String {
    /// HTTP GET
    case get = "GET"
    /// HTTP POST
    case post = "POST"
    /// HTTP PUT
    case put = "PUT"
    /// HTTP PATCH
    case patch = "PATCH"
    /// HTTP DELETE
    case delete = "DELETE"
}

/// Type alias used for HTTP request headers.
typealias ReaquestHeaders = [String: String]
/// Type alias used for HTTP request parameters. Used for query parameters for GET requests and in the HTTP body for POST, PUT and PATCH requests.
typealias RequestParameters = [String : String]
/// Type alias used for the HTTP request download/upload progress.
typealias ProgressHandler = (Float) -> Void
