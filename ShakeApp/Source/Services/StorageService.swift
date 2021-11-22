//
//  StorageService.swift
//  ShakeApp
//
//  Created by Softermii-User on 08.11.2021.
//

import Foundation

protocol StorageDataProvider: AnyObject {
    func readData(for key: String ) -> String?
    func writeData(_ data: String, for key: String)
}

final class StorageService: StorageDataProvider {
    
    // MARK: - Properties
    let storage: UserDefaults
    
    // MARK: - Init
    init(with storage: UserDefaults = .standard) {
        self.storage = storage
    }
    
    // MARK: - Functions
    func readData(for key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }

    func writeData(_ data: String, for key: String) {
        UserDefaults.standard.setValue(data, forKey: key)
    }
}
