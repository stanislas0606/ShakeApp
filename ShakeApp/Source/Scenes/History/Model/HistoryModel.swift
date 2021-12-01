//
//  HistoryModel.swift
//  ShakeApp
//
//  Created by Softermii-User on 01.12.2021.
//

import Foundation

final class HistoryModel {
    
    private let dbDataProvider: HistoryDBProvider
    
    // MARK: - Init
    init(with dbDataProvider: HistoryDBProvider) {
        self.dbDataProvider = dbDataProvider
    }
    
    func getHistoryFromDB() -> [HistoryData] {
            var history = [HistoryData]()
            dbDataProvider.fetchHistory()?.forEach({ item in
                history.append(item.toHistoryData())
            })
            return history
    }
}
