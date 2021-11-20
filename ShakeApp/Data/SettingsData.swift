//
//  SettingsData.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

struct SettingsData {
    let customAnswer: String
}

extension SettingsData {
    static func fromPresentableSettingsData(_ data: PresentableSettingsData) -> SettingsData {
        return SettingsData(customAnswer: data.customAnswer)
    }
}
