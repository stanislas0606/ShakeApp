//
//  MainViewModel.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import UIKit

class MainViewModel {

    // MARK: - Properties
    private let model: MainModel

    var shouldHandlerFetchData: ((String) -> Void)? {
        didSet {
            model.fetchDataHandler = shouldHandlerFetchData
        }
    }

    // MARK: - Init
    init(model: MainModel) {
        self.model = model
    }

    func loadData(for question: String) {
        model.loadData(for: question)
    }

    func getAnswer() -> PresentableAnswerData {
        return PresentableAnswerData(answerText: model.getAnswer())
    }

}
