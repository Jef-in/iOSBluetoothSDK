//
//  LoggerTests.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 26/11/25.
//


import Testing
@testable import BLESDK

@Suite
final class LoggerTests {
    @Test
    func testLoggerNoCrash() throws {
        let logger = Logger(category: "Test")
        logger.debug("debug")
        logger.info("info")
        logger.error("error")
        logger.fault("fault")
    }
}