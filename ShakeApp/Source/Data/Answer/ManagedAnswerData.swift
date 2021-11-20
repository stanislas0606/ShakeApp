//
//  ManagedAnswerData.swift
//  ShakeApp
//
//  Created by Softermii-User on 20.11.2021.
//

import Foundation

struct ManagedAnswerData: Codable {
    
    let magic: MagicData

    struct MagicData: Codable {
        let question: String
        let answer: String
        let type: String
    }
}

extension ManagedAnswerData {
    
    func toAnswerData() -> AnswerData {
        return AnswerData(question: self.magic.question,
                           answer: self.magic.answer,
                             type: self.magic.type)
    }
}
