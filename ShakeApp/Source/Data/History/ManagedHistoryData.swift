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
    dynamic var isLocal: Bool = false
    
    // MARK: - Init
    convenience init(answer: String, date: Date = Date(), isLocal: Bool) {
        self.init()
        self.answer = answer
        self.date = date
        self.isLocal = isLocal
    }
}
