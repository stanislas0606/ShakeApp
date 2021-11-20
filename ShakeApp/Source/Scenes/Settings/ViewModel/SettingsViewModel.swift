//
//  SettingsViewModel.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

final class SettingsViewModel {
    
    // MARK: - Properties
    private let model: SettingsModel
    
    var saveButtonHandler: ((String) -> Void)?
    
    // MARK: - Init
    init(model: SettingsModel) {
        self.model = model
        self.saveButtonHandler = { [weak self] text in
            self?.saveData(customData: SettingsData(customAnswer: text))
        }
    }
    
    func saveData(customData: SettingsData) {
        model.saveData(customData: customData)
    }
}
