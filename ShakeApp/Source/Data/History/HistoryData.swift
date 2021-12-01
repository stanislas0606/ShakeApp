//
//  HistoryData.swift
//  ShakeApp
//
//  Created by Softermii-User on 01.12.2021.
//

import Foundation

struct HistoryData {
    
    // MARK: - Properties
    let answer: String
    let date: Date
}

extension HistoryData {
    
    func toPresentableHistoryData() -> PresentableHistoryData {
        return PresentableHistoryData(from: self)
    }
}
