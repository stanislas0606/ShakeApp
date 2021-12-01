//
//  PresentableHistoryData.swift
//  ShakeApp
//
//  Created by Softermii-User on 01.12.2021.
//

import Foundation

struct PresentableHistoryData {
    
    // MARK: - Properties
    let model: HistoryData
    
    var historyText: String {
        let formatter = Formatters.Date.formatter
        let date = formatter.string(from: model.date)
        let answer = model.answer + "  \(String(describing: date))"
        
        return answer
    }
    
    // MARK: - Init
    init(from model: HistoryData) {
        self.model = model
    }
}
