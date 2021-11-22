//
//  ManagedSettingsData.swift
//  ShakeApp
//
//  Created by Softermii-User on 20.11.2021.
//

import Foundation

struct ManagedSettingsData {
    
    // MARK: - Properties
    let customAnswer: String
    let keyForCustomAnswer = L10n.Answer.Custom.key
}

extension ManagedSettingsData {
    
    func toSettingsData() -> SettingsData {
        return SettingsData(customAnswer: customAnswer)
    }
}
