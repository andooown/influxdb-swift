//
//  QueryResult.swift
//  SwiftInfluxDB
//
//  Created by Yoshikazu Ando on 2020/07/25.
//

import CSV
import Foundation

public enum QueryResultParseError: Error {
    /// An indication that there is only single row and failed to find the header.
    case headerNotFound
}

public struct QueryResult {
    public let tables: [Table]

    public init(data: Data) throws {
        let reader = try CSVReader(stream: InputStream(data: data))

        var tables = [Table]()
        while let table = try Self.parseTable(reader: reader) {
            tables.append(table)
        }

        self.tables = tables
    }

    private static func parseTable(reader: CSVReader) throws -> Table? {
        var datatype: [String]?
        var group: [String]?
        var defaultValue: [String]?
        var rows = [[String]]()

        while let row = reader.next() {
            guard row.count >= 2 else { break }

            switch row[0] {
            case "#datatype":
                datatype = row
            case "#group":
                group = row
            case "#default":
                defaultValue = row
            default:
                rows.append(row)
            }
        }
        
        

        switch rows.count {
        case 0:
            return nil
        case 1:
            throw QueryResultParseError.headerNotFound
        default:
            return Table(datatypes: datatype,
                         groups: group,
                         defaultValues: defaultValue,
                         columns: rows[0],
                         rawValues: Array(rows[1...]))
        }
    }
}
