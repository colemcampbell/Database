//
//  Database.swift
//
//
//  Created by Cole Campbell on 10/23/19.
//

import Foundation
import RealmSwift

public class Database {
    public let configuration: Database.Configuration
    
    public init(configuration: Database.Configuration) {
        self.configuration = configuration
    }
    
    public init() {
        self.configuration = .default
    }
}

extension Database {
    public func save<T: DatabaseEntry>(_ entry: T, withoutNotifying tokens: [NotificationToken] = []) throws {
        let realm = try Realm(configuration: self.configuration.realmConfiguration)
        
        try realm.write(withoutNotifying: tokens) {
            realm.add(entry)
        }
    }
    
    public func update<T: DatabaseEntry>(_ entry: T, with values: [String: Any], withoutNotifying tokens: [NotificationToken] = []) throws {
        var values = values
        values["id"] = entry.id
        
        let realm = try Realm(configuration: self.configuration.realmConfiguration)
        
        try realm.write(withoutNotifying: tokens) {
            realm.create(type(of: entry), value: values, update: .modified)
        }
    }
    
    public func overwrite<T: DatabaseEntry>(entryOfID id: String, withEntry entry: T, withoutNotifying tokens: [NotificationToken] = []) throws {
        entry.id = id
        
        let realm = try Realm(configuration: self.configuration.realmConfiguration)
        
        try realm.write(withoutNotifying: tokens) {
            realm.add(entry, update: .all)
        }
    }
    
    public func delete<T: DatabaseEntry>(_ entry: T, withoutNotifying tokens: [NotificationToken] = []) throws {
        let realm = try Realm(configuration: self.configuration.realmConfiguration)
        
        try realm.write(withoutNotifying: tokens) {
            realm.delete(entry)
        }
    }
    
    public func delete<T: DatabaseEntry>(_ entries: Results<T>, withoutNotifying tokens: [NotificationToken] = []) throws {
        let realm = try Realm(configuration: self.configuration.realmConfiguration)
        
        try realm.write(withoutNotifying: tokens) {
            realm.delete(entries)
        }
    }
    
    public func deleteAllEntries<T: DatabaseEntry>(ofType entryType: T.Type, withoutNotifying tokens: [NotificationToken] = []) throws {
        let allEntries = try self.entries(ofType: entryType)
        
        try self.delete(allEntries)
    }
    
    public func containsEntry<T: DatabaseEntry>(ofType entryType: T.Type, withID id: String) throws -> Bool {
        return try self.entry(ofType: entryType, withID: id) != nil ? true : false
    }
    
    public func entry<T: DatabaseEntry>(ofType entryType: T.Type, withID id: String) throws -> T? {
        let realm = try Realm(configuration: self.configuration.realmConfiguration)
        
        return realm.object(ofType: entryType, forPrimaryKey: ["id": id])
    }
    
    public func newestEntry<T: DatabaseEntry>(ofType entryType: T.Type) throws -> T? {
        return try self.entries(ofType: entryType, sortedBy: .newestFirst).first
    }
    
    public func oldestEntry<T: DatabaseEntry>(ofType entryType: T.Type) throws -> T? {
        return try self.entries(ofType: entryType, sortedBy: .oldestFirst).first
    }
    
    public func entries<T: DatabaseEntry>(ofType entryType: T.Type, sortedBy sortPredicate: Database.SortPredicate = .none) throws -> Results<T> {
        let realm = try Realm(configuration: self.configuration.realmConfiguration)
        
        var entries = realm.objects(entryType)
        
        switch sortPredicate {
            case .none:
                break
            case .oldestFirst:
                entries = entries.sorted(byKeyPath: "creationDate", ascending: true)
            case .newestFirst:
                entries = entries.sorted(byKeyPath: "creationDate", ascending: false)
        }
        
        return entries
    }
}

extension Database {
    private static let separator = "`"
    
    public static func arrayString<T: LosslessStringConvertible>(fromArray array: [T]) -> String {
        guard !array.isEmpty else {
            return ""
        }
        
        return array.map(String.init).joined(separator: self.separator)
    }
    
    public static func array<T: LosslessStringConvertible>(fromArrayString arrayString: String) -> [T] {
        guard !arrayString.isEmpty else { return [] }
        
        return arrayString.components(separatedBy: self.separator).map { T($0)! }
    }
}
