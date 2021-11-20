//
//  SettingsModel.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

final class SettingsModel {
    
    // MARK: - Properties
    private let storageDataProvider: StorageDataProvider
    
    // MARK: - Init
    init(storageDataProvider: StorageDataProvider) {
        self.storageDataProvider = storageDataProvider
    }

    func saveData(customData: SettingsData) {
        storageDataProvider.writeData(customData.customAnswer, for: customData.keyForCustomAnswer)
    }
}
