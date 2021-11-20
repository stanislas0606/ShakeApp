//
//  AnswerData.swift
//  ShakeApp
//
//  Created by Softermii-User on 21.10.2021.
//

import Foundation

struct AnswerData: Codable {
    
    // MARK: - Properties
    let question: String
    let answer: String
    let type: String
}

extension AnswerData {
    
    func toPresentableAnswerData() -> PresentableAnswerData {
        return PresentableAnswerData(from: self)
    }
}
