//
//  PresentableAnswerData.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

struct PresentableAnswerData {
    
    // MARK: - Properties
    private let model: AnswerData?
    private var customAnswer = ""
    
    var answerText: String {
        guard let model = model else {
            return customAnswer.uppercased()
        }
        return model.answer.uppercased()
    }
    
    // MARK: - Init
    init(from model: AnswerData) {
        self.model = model
    }
    
    init(with customAnswer: String) {
        self.customAnswer = customAnswer
        self.model = nil
    }
}
