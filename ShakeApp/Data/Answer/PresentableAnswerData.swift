//
//  PresentableAnswerData.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

struct PresentableAnswerData {
    var model: AnswerData
    
    init(from model: AnswerData) {
        self.model = model
    }
    
    var answerText: String {
        return model.answer.uppercased()
    }
}
