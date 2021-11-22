//
//  PresentableSettingsData.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

struct PresentableSettingsData {
    
    // MARK: - Properties
    let model: SettingsData
    
    var customAnswerText: String {
        return model.customAnswer
    }
    
    // MARK: - Init
    init(from model: SettingsData) {
        self.model = model
    }
}
