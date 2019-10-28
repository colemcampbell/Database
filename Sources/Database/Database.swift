//
//  Database.swift
//  SmartCalc
//
//  Created by Cole Campbell on 10/23/19.
//  Copyright © 2019 Black & Grey Studios. All rights reserved.
//

import Foundation
import RealmSwift

struct Database {
    private static let separator = "`"
    
    static func arrayString<T: LosslessStringConvertible>(fromArray array: [T]) -> String {
        guard !array.isEmpty else {
            return ""
        }
        
        return array.map(String.init).joined(separator: self.separator)
    }
    
    static func array<T: LosslessStringConvertible>(fromArrayString arrayString: String) -> [T] {
        guard !arrayString.isEmpty else { return [] }
        
        return arrayString.components(separatedBy: self.separator).map { T($0)! }
    }
    
    static func joinedArrayString(_ arrayString1: String, _ arrayString2: String) -> String {
        return "\(arrayString1)\(self.separator)\(arrayString2)"
    }
}

extension Database {
    static func save<T: DatabaseEntry>(_ entry: T, withoutNotifying tokens: [NotificationToken?] = []) throws {
        try Realm.write(withoutNotifying: tokens) { realm in
            realm.add(entry)
        }
    }
    
    static func update<T: DatabaseEntry>(_ entry: T, with values: [String: Any], withoutNotifying tokens: [NotificationToken?] = []) throws {
        var values = values
        values["id"] = entry.id
        
        try Realm.write(withoutNotifying: tokens) { realm in
            realm.create(type(of: entry), value: values, update: .modified)
        }
    }
    
    static func overwrite<T: DatabaseEntry>(_ entry: T, withoutNotifying tokens: [NotificationToken?] = []) throws {
        try Realm.write(withoutNotifying: tokens) { $0.add(entry, update: .all) }
    }
    
    static func delete<T: DatabaseEntry>(_ entry: T, withoutNotifying tokens: [NotificationToken?] = []) throws {
        try Realm.write(withoutNotifying: tokens) { $0.delete(entry) }
    }
    
    static func delete<T: DatabaseEntry>(_ entries: Results<T>, withoutNotifying tokens: [NotificationToken?] = []) throws {
        try Realm.write(withoutNotifying: tokens) { $0.delete(entries) }
    }
    
    static func deleteAllEntries<T: DatabaseEntry>(ofType entryType: T.Type, withoutNotifying tokens: [NotificationToken?] = []) throws {
        let allEntries = try self.entries(ofType: entryType)
        try self.delete(allEntries)
    }
    
    static func containsEntry<T: DatabaseEntry>(ofType entryType: T.Type, withID id: String) throws -> Bool {
        return try self.entry(ofType: entryType, withID: id) != nil ? true : false
    }
    
    static func entry<T: DatabaseEntry>(ofType entryType: T.Type, withID id: String) throws -> T? {
        return try Realm.default().object(ofType: entryType, forPrimaryKey: ["id": id])
    }
    
    static func entries<T: DatabaseEntry>(ofType entryType: T.Type) throws -> Results<T> {
        return try Realm.default().objects(entryType)
    }
}
