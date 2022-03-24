//
//  Logger.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import Foundation

public final class Logger {
    
    public static let shared = Logger()
    private init() {}
    
    public static func verbose(_ log: String, function: StaticString = #function, line: UInt = #line, file: StaticString = #file) {
        debugPrint(prepareConsoleLog(message: log, function: String(describing: function), line: Int(line), file: String(describing: file), level: .verbose))
    }
    
    public static func info(_ log: String, function: StaticString = #function, line: UInt = #line, file: StaticString = #file) {
        debugPrint(prepareConsoleLog(message: log, function: String(describing: function), line: Int(line), file: String(describing: file), level: .info))
    }
    
    public static func debug(_ log: String, function: StaticString = #function, line: UInt = #line, file: StaticString = #file) {
        debugPrint(prepareConsoleLog(message: log, function: String(describing: function), line: Int(line), file: String(describing: file), level: .debug))
    }
    
    public static func warning(_ log: String, function: StaticString = #function, line: UInt = #line, file: StaticString = #file) {
        debugPrint(prepareConsoleLog(message: log, function: String(describing: function), line: Int(line), file: String(describing: file), level: .warning))
    }
    
    public static func error(_ log: String, function: StaticString = #function, line: UInt = #line, file: StaticString = #file) {
        debugPrint(prepareConsoleLog(message: log, function: String(describing: function), line: Int(line), file: String(describing: file), level: .error))
    }
    
    public static func detailedError(error: Error?, function: StaticString = #function, file: StaticString = #file, line: UInt = #line) {
        guard let error = error else { return }
        let logFormat =  "\nDomain: %@ \nCode: %@ \nDescription: %@ \nUserInfo: %@"
        let nsError = error as NSError
        let log = String(format: logFormat, nsError.domain, String(nsError.code), nsError.localizedDescription, nsError.userInfo)
        debugPrint(prepareConsoleLog(message: log, function: String(describing: function), line: Int(line), file: String(describing: file), level: .error))
    }
    
    static func prepareConsoleLog(message: String, function: String, line: Int,
                                  file: String, level: Logger.LogLevel) -> String {
        return replaceTemplate(message: message, function: function, line: line, file: file, date: formatLogDate(Date()), level: level)
    }
    
    private static func replaceTemplate(message: String, function: String, line: Int,
                                        file: String, date: String, level: Logger.LogLevel) -> String {
        
        var template =
        "#line_break# #logger_signature# #log_level# #date# Func: #function#, File: #file#, l: #line#" +
        "#line_break# #indicator# Message: #message#"
        let url = URL(fileURLWithPath: file)
        
        #if DEBUG
                let indicator = level.indicator
                let signature = "[📋 SpeedyPay Logger]"
                let date = "[⏰ \(date)]"
                let level = "[🔎 \(level.name)]"
        #else
                let indicator = "=>"
                let signature = "[LOG]"
                let date = "[\(date)]"
                let level = "[\(level.name)]"
        #endif
        
        let templateDictionary: [String: Any] = ["line_break": "\n",
                                                 "logger_signature": signature,
                                                 "log_level": level,
                                                 "date": date,
                                                 "indicator": indicator,
                                                 "message": message,
                                                 "function": function,
                                                 "file": url.lastPathComponent,
                                                 "line": "\(line)"]
        
        for (key, value) in templateDictionary {
            if let stringToReplaced = value as? String {
                template = template.replacingOccurrences(of: "#" + key + "#", with: stringToReplaced)
            }
        }
        
        return template
    }
    
    private static func formatLogDate(_ date: Date) -> String {
        let format = "dd/MM/yyyy HH:mm:ss.SSS"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
