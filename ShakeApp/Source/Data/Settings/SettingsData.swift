//
//  SettingsData.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

struct SettingsData {
    
    // MARK: - Properties
    let customAnswer: String
    let keyForCustomAnswer = L10n.Answer.Custom.key
}

extension SettingsData {
    
    func toPresentableSettingsData () -> PresentableSettingsData {
        return PresentableSettingsData(from: self)
    }
}
