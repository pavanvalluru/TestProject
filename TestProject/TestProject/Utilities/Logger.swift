//
//  Logger.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//  Source: https://github.com/sauvikdolui/swiftlogger/blob/master/SwiftLogger/Debug/Logger.swift
//

import Foundation

/// Enum which maps an appropiate symbol which added as prefix for each log message
///
/// - error: Log type error
/// - info: Log type info
/// - debug: Log type debug
/// - verbose: Log type verbose
/// - warning: Log type warning
/// - severe: Log type severe
private enum LogEvent: String {
    // cases sorted in priority level
    case verbose = "[🔬]" // verbose
    case debug = "[💬]" // debug
    case info = "[ℹ️]" // info
    case warning = "[⚠️]" // warning
    case error = "[‼️]" // error
    case severe = "[🔥]" // severe
}

/// Wrapping Swift.print() within DEBUG flag
///
/// - Note: *print()* might cause [security vulnerabilities](https://codifiedsecurity.com/mobile-app-security-testing-checklist-ios/)
///
/// - Parameter object: The object which is to be logged
///
func print(_ object: Any) {
    // Only allowing in DEBUG mode
    #if DEBUG
    Swift.print(object)
    #endif
}

class Log {

    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    // MARK: - Loging methods

    /// Logs error messages on console with prefix [‼️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func error( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column,
                      funcName: String = #function) {
        if isLoggingEnabled {
            printFormatted(object, logEvent: .error, filename: filename,
                           line: line, column: column, funcName: funcName)
        }
    }

    /// Logs info messages on console with prefix [ℹ️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func info( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column,
                     funcName: String = #function) {
        if isLoggingEnabled {
            printFormatted(object, logEvent: .info, filename: filename,
                           line: line, column: column, funcName: funcName)
        }
    }

    /// Logs debug messages on console with prefix [💬]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func debug( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column,
                      funcName: String = #function) {
        if isLoggingEnabled {
            printFormatted(object, logEvent: .debug, filename: filename,
                           line: line, column: column, funcName: funcName)
        }
    }

    /// Logs messages verbosely on console with prefix [🔬]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func verbose( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column,
                        funcName: String = #function) {
        if isLoggingEnabled {
            printFormatted(object, logEvent: .verbose, filename: filename,
                           line: line, column: column, funcName: funcName)
        }
    }

    /// Logs warnings verbosely on console with prefix [⚠️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func warning( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column,
                        funcName: String = #function) {
        if isLoggingEnabled {
            printFormatted(object, logEvent: .warning, filename: filename,
                           line: line, column: column, funcName: funcName)
        }
    }

    /// Logs severe events on console with prefix [🔥]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func severe( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column,
                       funcName: String = #function) {
        if isLoggingEnabled {
            printFormatted(object, logEvent: .severe, filename: filename,
                           line: line, column: column, funcName: funcName)
        }
    }

    /// Extract the file name from the file path
    ///
    /// - Parameter filePath: Full file path in bundle
    /// - Returns: File Name with extension
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }

    /// Format print statement as needed
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - logEvent: Category of the message being logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    // swiftlint:disable function_parameter_count
    private class func printFormatted( _ object: Any, logEvent: LogEvent, filename: String, line: Int, column: Int,
                                       funcName: String) {
    // swiftlint:enable function_parameter_count
        print("\(Date().toString()) \(logEvent.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
}

internal extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}
