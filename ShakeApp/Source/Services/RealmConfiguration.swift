//
//  RealmConfiguration.swift
//  ShakeApp
//
//  Created by Softermii-User on 01.12.2021.
//

import Foundation
import RealmSwift

final class RealmConfiguration {
    
    private let schemaVersion : UInt64 = 1
    
    private (set) lazy var realmConfiguration: Realm.Configuration = {
        return Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: migrationBlock, deleteRealmIfMigrationNeeded: false)
    }()
    
    init() {
        Realm.Configuration.defaultConfiguration = realmConfiguration
    }

    private func migrationBlock(migration: RealmSwift.Migration, oldSchemaVersion: UInt64) {
        
    }
}
