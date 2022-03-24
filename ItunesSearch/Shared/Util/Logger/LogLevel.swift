//
//  LogLevel.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import Foundation

extension Logger {

    enum LogLevel: String {
        
        case error
        case warning
        case info
        case verbose
        case debug
        
        var indicator: String {
            switch self {
            case .error: return "🚨"
            case .warning: return "⚠️"
            case .info: return "ℹ️"
            case .verbose: return "🌐"
            case .debug: return "🐞"
            }
        }
        
        var name: String {
            switch self {
            case .debug:
                return "DEBUG"
            case .error:
                return "ERROR"
            case .info:
                return "INFO"
            case .verbose:
                return "VERBOSE"
            case .warning:
                return "WARNING"
            }
        }
    }
}
