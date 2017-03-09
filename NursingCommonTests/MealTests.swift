//
//  MealTests.swift
//  Nursing
//
//  Created by Markus Svensson on 2017-03-09.
//  Copyright © 2017 Markus Svensson. All rights reserved.
//

import XCTest
import NursingCommon
import SwiftMoment

class MealTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasCorrectInitValues() {
        let dut = Meal()
        XCTAssertEqual(dut.duration, 0, "Init value of duration should be 0")
        XCTAssertEqual(dut.type, MealType.leftBreast, "Init value of type should be leftbreast")
        
        let date = Date()
        var cal = Calendar.current
        cal.timeZone = TimeZone.current
        let params: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second, .weekday,
                                               .weekdayOrdinal, .weekOfYear, .quarter]
        let components = cal.dateComponents(params, from: date)
        
        XCTAssertEqual(dut.start.year, components.year, "The start moment contains the current year")
        XCTAssertEqual(dut.start.month, components.month, "The start moment contains the current month")
        XCTAssertEqual(dut.start.day, components.day, "The start moment contains the current day")
        XCTAssertEqual(dut.start.hour, components.hour, "The start moment contains the current hour")
        XCTAssertEqual(dut.start.minute, components.minute, "The start moment contains the current minute")
        XCTAssertEqual(dut.start.second, components.second, "The start moment contains the current second")
        XCTAssertEqual(dut.start.weekday, components.weekday, "The start moment contains the current weekday")
        XCTAssertEqual(dut.start.weekOfYear, components.weekOfYear,
                       "The start moment contains the current week of year")
        XCTAssertEqual(dut.start.weekdayOrdinal, components.weekdayOrdinal,
                       "The start moment contains the current number of the week day")
        XCTAssertEqual(dut.start.quarter, components.quarter, "The start moment contains the current quarter")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let weekdayName = formatter.string(from: date)
        
        XCTAssertEqual(dut.start.weekdayName, weekdayName, "The start moment contains the current week day")
    }
    
    func testCanInitWithParameters() {
        let dut = Meal(duration: 5, type: .rightBreast, start: moment([2015, 01, 19, 20, 45])!)
        
        XCTAssertEqual(dut.duration, 5, "The duration should match")
        XCTAssertEqual(dut.type, MealType.rightBreast, "The type should match")
        XCTAssertEqual(dut.start.year, 2015, "The year should match")
        XCTAssertEqual(dut.start.month, 01, "The month should match")
        XCTAssertEqual(dut.start.day, 19, "The day should match")
        XCTAssertEqual(dut.start.hour, 20, "The hour should match")
        XCTAssertEqual(dut.start.minute, 45, "The minute should match")
        XCTAssertEqual(dut.start.second, 0, "The second should be zero")
    }
    
    func testInitWithParametersPerformance() {
        // This is an example of a performance test case.
        self.measure {
            let dut = Meal(duration: 5, type: .rightBreast, start: moment([2015, 01, 19, 20, 45])!)
        }
    }
    
}
