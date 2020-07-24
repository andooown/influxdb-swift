//
//  Table.swift
//  SwiftInfluxDB
//
//  Created by Yoshikazu Ando on 2020/07/25.
//

import Foundation

public struct Table {
    let datatypes: [String]?
    let groups: [String]?
    let defaultValues: [String]?
    public let columns: [String]
    let rawValues: [[String]]

    public var recordCount: Int {
        rawValues.count
    }

    public subscript(recordAt recordIndex: Int) -> Record {
        Record(columns: columns,
               values: rawValues[recordIndex],
               datatypes: datatypes,
               groups: groups,
               defaultValues: defaultValues)
    }

    public var records: [Record] {
        (0..<recordCount).map { self[recordAt: $0] }
    }

    public var formattedString: String {
        let columnLength: [Int] = (0..<columns.count)
                .map { (columnIndex: Int) -> Int in
                    let columnLength = columns[columnIndex].count
                    let recordLengths = rawValues.map({ $0[columnIndex].count })
                    return ([columnLength] + recordLengths).max()!
                }

        let padValues = { (values: [String], paddedWith: String, joinedWith: String) -> String in
            zip(columnLength, values)
                    .map { length, value in
                        value.padding(toLength: length, withPad: paddedWith, startingAt: 0)
                    }
                    .joined(separator: joinedWith)
        }

        var resultLines = [String]()
        resultLines.append("| \(padValues(columns, " ", " | ")) |")
        resultLines.append("|-\(padValues([String](repeating: "", count: columns.count), "-", "-|-"))-|")
        for row in rawValues {
            resultLines.append("| \(padValues(row, " ", " | ")) |")
        }

        return resultLines.joined(separator: "\n")
    }
}
