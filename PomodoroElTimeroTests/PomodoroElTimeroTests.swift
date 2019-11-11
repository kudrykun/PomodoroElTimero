//
//  PomodoroElTimeroTests.swift
//  PomodoroElTimeroTests
//
//  Created by Macbook on 11/11/2019.
//  Copyright © 2019 Sergey Vasilenko. All rights reserved.
//

import XCTest

class PomodoroElTimeroTests: XCTestCase {
    var model: UserSettingsModel = UserSettingsModel()

    override func setUp() {
        model = UserSettingsModel()
    }

    override func tearDown() {
    }

    func testGetFormattedTimeReturns0SecondsCorrectly() {
        testGetFormattedTime(inputValue: 0, expectedValue: "00 : 00")
    }

    func testGetFormattedTimeReturns1SecondsCorrectly() {
        testGetFormattedTime(inputValue: 1, expectedValue: "00 : 01")
    }

    func testGetFormattedTimeReturns10SecondsCorrectly() {
        testGetFormattedTime(inputValue: 10, expectedValue: "00 : 10")
    }
    func testGetFormattedTimeReturns11SecondsCorrectly() {
        testGetFormattedTime(inputValue: 11, expectedValue: "00 : 11")
    }
    func testGetFormattedTimeReturns59SecondsCorrectly() {
        testGetFormattedTime(inputValue: 59, expectedValue: "00 : 59")
    }
    func testGetFormattedTimeReturns60SecondsCorrectly() {
        testGetFormattedTime(inputValue: 60, expectedValue: "01 : 00")
    }
    func testGetFormattedTimeReturns61SecondsCorrectly() {
        testGetFormattedTime(inputValue: 61, expectedValue: "01 : 01")
    }
    func testGetFormattedTimeReturns125SecondsCorrectly() {
        testGetFormattedTime(inputValue: 125, expectedValue: "02 : 05")
    }
    func testGetFormattedTimeReturns625SecondsCorrectly() {
        testGetFormattedTime(inputValue: 625, expectedValue: "10 : 25")
    }
    func testGetFormattedTimeReturnsMinus1SecondsCorrectly() {
        testGetFormattedTime(inputValue: -1, expectedValue: nil)
    }
    func testGetFormattedTimeReturns3600SecondsCorrectly() {
        testGetFormattedTime(inputValue: 3600, expectedValue: nil)
    }
    func testGetFormattedTimeReturnsMoreThan3600SecondsCorrectly() {
        testGetFormattedTime(inputValue: 4600, expectedValue: nil)
    }


    func testGetFormattedTime(inputValue: Int, expectedValue: String?) {
        let formattedTime = model.getFormattedTime(from: inputValue)
        XCTAssert(formattedTime == expectedValue, "Formatted value is not correct! Received \"\(String(describing: formattedTime))\" instead of \"\(String(describing: expectedValue))\"")
    }

}
