//
//  MainViewModel.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

final class MainViewModel {

    // MARK: - Properties
    private let model: MainModel
    
    var motionHandler: ((String) -> Void)?
    var shouldHandlerFetchData: ((PresentableAnswerData) -> Void)? {
        didSet {
            model.fetchDataHandler = shouldHandlerFetchData
        }
    }

    // MARK: - Init
    init(model: MainModel) {
        self.model = model
        motionHandler = { [weak self] text in
            self?.loadData(for: text)
        }
    }

    private func loadData(for question: String) {
        model.loadData(for: question)
    }
}
