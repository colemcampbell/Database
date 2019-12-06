//
//  DatabaseConfiguration.swift
//  
//
//  Created by Cole Campbell on 12/5/19.
//

import Foundation
import RealmSwift

extension Database {
    public struct Configuration {
        public let fileURL: URL?
        public let inMemoryIdentifier: String?
        public let syncConfiguration: SyncConfiguration?
        public let encryptionKey: Data?
        public let readOnly: Bool
        public let schemaVersion: UInt64
        public let migrationBlock: MigrationBlock?
        public let deleteDatabaseIfMigrationNeeded: Bool
        public let shouldCompactOnLaunch: ((Int, Int) -> Bool)?
        public let databaseEntryTypes: [DatabaseEntry.Type]?
        
        public static let `default` = Database.Configuration(realmConfiguration: Realm.Configuration.defaultConfiguration)
        
        public init(fileURL: URL? = Configuration.default.fileURL,
                    inMemoryIdentifier: String? = Configuration.default.inMemoryIdentifier,
                    syncConfiguration: SyncConfiguration? = Configuration.default.syncConfiguration,
                    encryptionKey: Data? = Configuration.default.encryptionKey,
                    readOnly: Bool = Configuration.default.readOnly,
                    schemaVersion: UInt64 = Configuration.default.schemaVersion,
                    migrationBlock: MigrationBlock? = Configuration.default.migrationBlock,
                    deleteDatabaseIfMigrationNeeded: Bool = Configuration.default.deleteDatabaseIfMigrationNeeded,
                    shouldCompactOnLaunch: ((Int, Int) -> Bool)? = Configuration.default.shouldCompactOnLaunch,
                    databaseEntryTypes: [DatabaseEntry.Type]? = Configuration.default.databaseEntryTypes) {
            
            self.fileURL = fileURL
            self.inMemoryIdentifier = inMemoryIdentifier
            self.syncConfiguration = syncConfiguration
            self.encryptionKey = encryptionKey
            self.readOnly = readOnly
            self.schemaVersion = schemaVersion
            self.migrationBlock = migrationBlock
            self.deleteDatabaseIfMigrationNeeded = deleteDatabaseIfMigrationNeeded
            self.shouldCompactOnLaunch = shouldCompactOnLaunch
            self.databaseEntryTypes = databaseEntryTypes
        }
    }
}

extension Database.Configuration {
    var realmConfiguration: Realm.Configuration {
        return Realm.Configuration(fileURL: self.fileURL,
                                   inMemoryIdentifier: self.inMemoryIdentifier,
                                   syncConfiguration: self.syncConfiguration,
                                   encryptionKey: self.encryptionKey,
                                   readOnly: self.readOnly,
                                   schemaVersion: self.schemaVersion,
                                   migrationBlock: self.migrationBlock,
                                   deleteRealmIfMigrationNeeded: self.deleteDatabaseIfMigrationNeeded,
                                   shouldCompactOnLaunch: self.shouldCompactOnLaunch,
                                   objectTypes: self.databaseEntryTypes)
    }
    
    init(realmConfiguration: Realm.Configuration) {
        self.init(fileURL: realmConfiguration.fileURL,
                  inMemoryIdentifier: realmConfiguration.inMemoryIdentifier,
                  syncConfiguration: realmConfiguration.syncConfiguration,
                  encryptionKey: realmConfiguration.encryptionKey,
                  readOnly: realmConfiguration.readOnly,
                  schemaVersion: realmConfiguration.schemaVersion,
                  migrationBlock: realmConfiguration.migrationBlock,
                  deleteDatabaseIfMigrationNeeded: realmConfiguration.deleteRealmIfMigrationNeeded,
                  shouldCompactOnLaunch: realmConfiguration.shouldCompactOnLaunch,
                  databaseEntryTypes: realmConfiguration.objectTypes?.compactMap { $0 as? DatabaseEntry.Type })
    }
}
