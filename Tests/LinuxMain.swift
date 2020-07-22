import XCTest

import SwiftInfluxDBTests

var tests = [XCTestCaseEntry]()
tests += SwiftInfluxDBTests.allTests()
XCTMain(tests)
