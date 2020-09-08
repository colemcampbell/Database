//
//  DatabaseEntry.swift
//
//
//  Created by Cole Campbell on 10/23/19.
//

import Foundation
import RealmSwift

open class DatabaseEntry: Object {
    @objc public dynamic var createdAt: Date = Date()
    @objc public dynamic var updatedAt: Date = Date()
    
    public override static func indexedProperties() -> [String] {
        ["createdAt"]
    }
}
