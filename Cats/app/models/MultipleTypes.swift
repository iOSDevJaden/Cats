//
//  MultipleTypes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/31.
//

import Foundation

/**
 * MARK - MultipleTypes is to prevent that decoding error from network response.
 */
enum MultipleTypes: Codable {
    
    case stringValue(String)
    case intValue(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .stringValue(value)
            return
        }
        
        if let value = try? container.decode(Int.self) {
            self = .intValue(value)
            return
        }

        throw DecodingError.typeMismatch(
            MultipleTypes.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Wrong type for ValueWrapper")
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .stringValue(value):
            try container.encode(value)
        case let .intValue(value):
            try container.encode(value)
        }
    }

    var rawValue: String {
        var result: String
        switch self {
        case .stringValue(let value): result = value
        case .intValue(let value):    result = String(value)
        }
        return result
    }

    var intValue: Int? {
        var result: Int?
        switch self {
        case let .stringValue(value): result = Int(value)
        case let .intValue(value):    result = value
        }
        return result
    }
}
