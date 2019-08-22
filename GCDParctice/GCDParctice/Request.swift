//
//  Request.swift
//  GCDParctice
//
//  Created by 黃建程 on 2019/8/22.
//  Copyright © 2019 Spark. All rights reserved.
//

import Foundation
struct DataResult: Codable {
    let result: result
}

struct result: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let sort: String
    let results: [results]
}

struct results: Codable {
    let functions: String
    let area: String
    let no: String
    let direction: String
    let sppedLimit: String
    let location: String
    let id: Int
    let road: String
    
    enum CodingKeys: String, CodingKey {
        case functions, area, no, direction, location, road
        case id = "_id"
        case sppedLimit = "speed_limit"
    }
}
