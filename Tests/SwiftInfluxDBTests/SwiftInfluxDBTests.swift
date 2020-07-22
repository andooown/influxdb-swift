import XCTest
@testable import SwiftInfluxDB

final class SwiftInfluxDBTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftInfluxDB().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
