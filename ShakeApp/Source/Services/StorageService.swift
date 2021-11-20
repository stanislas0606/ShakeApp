//
//  StorageService.swift
//  ShakeApp
//
//  Created by Softermii-User on 08.11.2021.
//

import Foundation

protocol StorageDataProvider {
    func readData(for key: String ) -> String?
    func writeData(_ data: String, for key: String)
}

final class StorageService: StorageDataProvider {
    
    // MARK: - Functions
    func readData(for key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }

    func writeData(_ data: String, for key: String) {
        UserDefaults.standard.setValue(data, forKey: key)
    }
}
