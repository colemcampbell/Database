//
//  DatabaseError.swift
//  SmartCalc
//
//  Created by Cole Campbell on 10/19/19.
//  Copyright © 2019 Black & Grey Studios. All rights reserved.
//

import Foundation

enum DatabaseError {
    case writeFailure, deleteFailure, readFailure
}

// MARK: LocalizedError

extension DatabaseError: LocalizedError {
    var errorDescription: String? {
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
