//
//  HistoryViewModel.swift
//  ShakeApp
//
//  Created by Softermii-User on 01.12.2021.
//

import Foundation

final class HistoryViewModel {
    
    // MARK: - Properties
    private let model: HistoryModel
    private var history: [HistoryData]
    
    // MARK: - Init
    init(model: HistoryModel) {
        self.model = model
        self.history = model.getHistoryFromDB().reversed()
    }
    
    func countOfHistory() -> Int {
        return history.count
    }
    
    func history(at index: Int) -> PresentableHistoryData {
        return history[index].toPresentableHistoryData()
        
    }
    
    func updateHistory() {
        let historyFromBD = model.getHistoryFromDB()
        history = historyFromBD.reversed()
    }
    
}
