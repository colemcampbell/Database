//
//  Realm.swift
//  SmartCalc
//
//  Created by Cole Campbell on 10/1/19.
//  Copyright © 2019 Black & Grey Studios. All rights reserved.
//

import Foundation
import RealmSwift
//import KeychainAccess

extension Realm {
    private static let keychainKey = "encrypted-realm"
    
    static func `default`() throws -> Realm {
//        let configuration: Realm.Configuration
//        let keychain = Keychain.appDefault
//
//        if let encryptionKey = try? keychain.getData(self.keychainKey) {
//            configuration = .init(encryptionKey: encryptionKey)
//        }
//        else {
//            let encryptionKey = try Keychain.encryptionKey()
//            try keychain.set(encryptionKey, key: self.keychainKey)
//
//            configuration = .init(encryptionKey: encryptionKey)
//        }
//
//        return try Realm(configuration: configuration)
        
        return try Realm()
    }
    
    static func write(withoutNotifying tokens: [NotificationToken?] = [], block: (Realm) throws -> Void) throws {
        let realm = try Realm.default()
        let tokens = tokens.filter { $0 != nil }.map { $0! }
        try realm.write(withoutNotifying: tokens) {
            try block(realm)
        }
    }
}
