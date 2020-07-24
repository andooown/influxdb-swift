//
//  QueryResultTests.swift
//  SwiftInfluxDBTests
//
//  Created by Yoshikazu Ando on 2020/07/25.
//

import XCTest
import SwiftInfluxDB

class QueryResultTests: XCTestCase {
    private let response1 =
            """
            #datatype,string,long,string,string,string,string,long
            #group,false,false,false,false,true,false,false
            #default,_result,,,,,,
            ,result,table,name,id,organizationID,retentionPolicy,retentionPeriod
            ,,0,_internal/monitor,,,monitor,604800000000000
            ,,0,NOAA_water_database/autogen,,,autogen,0

            """.data(using: .utf8)!

    func testParseResponse1() throws {
        let result = try QueryResult(data: response1)
        XCTAssertEqual(result.tables.count, 1)

        let table = result.tables[0]
        XCTAssertEqual(table.recordCount, 2)

        let expectedColumns = ["", "result", "table", "name", "id", "organizationID", "retentionPolicy", "retentionPeriod"]
        XCTAssertEqual(table.columns, expectedColumns)
        for columns in table.records.map(\.columns) {
            XCTAssertEqual(columns, expectedColumns)
        }

        XCTAssertEqual(table[recordAt: 0].values,
                       ["", "", "0", "_internal/monitor", "", "", "monitor", "604800000000000"])
        XCTAssertEqual(table[recordAt: 1].values,
                       ["", "", "0", "NOAA_water_database/autogen", "", "", "autogen", "0"])
    }

    static var allTests = [
        ("testParseResponse1", testParseResponse1)
    ]
}
