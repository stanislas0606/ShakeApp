//
//  PresentableAnswerData.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

struct PresentableAnswerData {
    
    // MARK: - Properties
    private var model: AnswerData?
    private var errorAnswer = ""
    
    var answerText: String {
        guard let model = model else {
            return errorAnswer.uppercased()
        }
        return model.answer.uppercased()
    }
    
    // MARK: - Init
    init(from model: AnswerData) {
        self.model = model
    }
    
    init(with errorAnswer: String) {
        self.errorAnswer = errorAnswer
    }
}
