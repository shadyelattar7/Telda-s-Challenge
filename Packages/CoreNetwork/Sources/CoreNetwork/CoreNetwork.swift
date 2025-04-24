// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public enum NetworkError: Error {
    case operationCancelled
    case requestFailed(error: Error)
    case unknownStatusCode
    case unexpectedStatusCode(code: Int)
    case contentEmptyData
    case contentDecoding(error: Error)
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .operationCancelled:
            return "Operation was cancelled"
        case let .requestFailed(error):
            return "Request failed with \(error)"
        case .unknownStatusCode:
            return "The status code is unknown"
        case let .unexpectedStatusCode(error):
            return "The status code is unexpected \(error)"
        case .contentEmptyData:
            return "The contyent data is empty"
        case let .contentDecoding(error):
            return "Error while decoding with \(error)"
        }
    }
}
