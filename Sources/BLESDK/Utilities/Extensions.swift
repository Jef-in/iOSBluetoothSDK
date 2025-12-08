//
//  Extensions.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//

import Foundation

// MARK: - Data Extensions
extension Data {
    /// Converts data to a hex string representation
    public var hexString: String {
        map { String(format: "%02hhx", $0) }.joined()
    }
}
