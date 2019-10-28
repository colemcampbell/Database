//
//  DatabaseEntry.swift
//  SmartCalc
//
//  Created by Cole Campbell on 10/23/19.
//  Copyright © 2019 Black & Grey Studios. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseEntry: Object {
    @objc dynamic var id: String = formattedID
    @objc dynamic var creationDate: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

private var formattedID: String {
    let id = UUID().uuidString
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    
    let date = dateFormatter.string(from: Date())
    
    return id + " " + date
}
