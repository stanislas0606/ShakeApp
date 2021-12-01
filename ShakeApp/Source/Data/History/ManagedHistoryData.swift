//
//  ManagedHistoryData.swift
//  ShakeApp
//
//  Created by Softermii-User on 01.12.2021.
//

import RealmSwift

@objcMembers class ManagedHistoryData: Object {
    
    // MARK: - Properties
    dynamic var answer: String = ""
    dynamic var date = Date()
    
    // MARK: - Init
    convenience init(answer: String, date: Date = Date()) {
        self.init()
        self.answer = answer
        self.date = date
    }
}

extension ManagedHistoryData {
    
    func toHistoryData() -> HistoryData {
        return HistoryData(answer: answer,
                           date: date)
    }
}
