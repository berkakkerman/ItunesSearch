//
//  NetworkError.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import Foundation

/// Enum of API Errors
public enum NetworkError: Error {
    /// No data received from the server.
    case noData
    /// The server response was invalid (unexpected format).
    case invalidResponse
    /// The request was rejected: 400-499
    case badRequest(Int, String?)
    /// Encoutered a server error.
    case serverError(Int, String?)
    /// There was an error parsing the data.
    case parseError(String?)
    /// Unknown error.
    case unknown(String?)
}
