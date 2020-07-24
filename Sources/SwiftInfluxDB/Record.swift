//
//  Record.swift
//  SwiftInfluxDB
//
//  Created by Yoshikazu Ando on 2020/07/25.
//

import Foundation

public struct Record {
    public let columns: [String]
    private let valueMap: [String: String]
    
    let datatypes: [String]?
    let groups: [String]?
    let defaultValues: [String]?
    
    public init(columns: [String],
                values: [String],
                datatypes: [String]?,
                groups: [String]?,
                defaultValues: [String]?) {
        self.columns = columns
        self.valueMap = [String: String](uniqueKeysWithValues: zip(columns, values))
        self.datatypes = datatypes
        self.groups = groups
        self.defaultValues = defaultValues
    }
    
    public var values: [String] {
        columns.compactMap { valueMap[$0] }
    }
    
    public subscript(_ column: String) -> String? {
        valueMap[column]
    }
}
