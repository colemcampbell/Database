//
//  DatabaseEntry.swift
//
//
//  Created by Cole Campbell on 10/23/19.
//

import Foundation
import RealmSwift

public class DatabaseEntry: Object {
    @objc public dynamic var id: String = DatabaseEntry.formattedID
    @objc public dynamic var creationDate: Date = Date()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
    public override static func indexedProperties() -> [String] {
        return ["creationDate"]
    }
}

extension DatabaseEntry {
    private static var formattedID: String {
        let id = UUID().uuidString
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        let date = dateFormatter.string(from: Date())
        
        return id + " " + date
    }
}
