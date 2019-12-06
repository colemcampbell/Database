//
//  DatabaseError.swift
//
//
//  Created by Cole Campbell on 10/19/19.
//

import Foundation

public enum DatabaseError {
    case writeFailure, deleteFailure, readFailure
}

// MARK: LocalizedError

extension DatabaseError: LocalizedError {
    public var errorDescription: String? {
        let beginningOfMessage: String
        
        switch self {
            case .writeFailure:
                beginningOfMessage = "Failed to save data."
            case .deleteFailure:
                beginningOfMessage = "Failed to delete data."
            case .readFailure:
                beginningOfMessage = "Failed to read data."
        }
        
        return "\(beginningOfMessage) Please check your device storage and try again."
    }
}
