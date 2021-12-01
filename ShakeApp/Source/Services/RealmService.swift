//
//  RealmService.swift
//  ShakeApp
//
//  Created by Softermii-User on 01.12.2021.
//

import RealmSwift

protocol HistoryDBProvider {
    func saveHistory(_ history: ManagedHistoryData)
    func fetchHistory() -> Results<ManagedHistoryData>?
}

final class RealmService: HistoryDBProvider {
    
    private var configuration: RealmConfiguration
    
    // MARK: - Init
    init(with configuration: RealmConfiguration = RealmConfiguration()) {
        self.configuration = configuration
    }
    
    func getRealm() throws -> Realm {
        debugPrint(configuration.realmConfiguration)
        
        return try Realm(configuration: configuration.realmConfiguration)
    }
    
    func saveHistory(_ history: ManagedHistoryData) {
        DispatchQueue.global(qos: .background).async { [self] in
            autoreleasepool {
                do {
                    let realm = try getRealm()
                    try realm.write {
                        realm.add(history)
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchHistory() -> Results<ManagedHistoryData>? {
        DispatchQueue.global(qos: .background).sync {
            do {
                let realm = try getRealm()
                return realm.objects(ManagedHistoryData.self)
            } catch {
                debugPrint(error.localizedDescription)
                return nil
            }
        }
    }
}
