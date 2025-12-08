//
//  Logger.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//


import Foundation
import os.log

/// Logger for BLE SDK events
public class Logger {
    private let osLog: OSLog
    
    public init(subsystem: String = "com.blesdk", category: String = "BLE") {
        self.osLog = OSLog(subsystem: subsystem, category: category)
    }
    
    /// Log debug information
    public func debug(_ message: String) {
        os_log("%{public}@", log: osLog, type: .debug, message)
    }
    
    /// Log general information
    public func info(_ message: String) {
        os_log("%{public}@", log: osLog, type: .info, message)
    }
    
    /// Log error information
    public func error(_ message: String) {
        os_log("%{public}@", log: osLog, type: .error, message)
    }
    
    /// Log fault information
    public func fault(_ message: String) {
        os_log("%{public}@", log: osLog, type: .fault, message)
    }
}