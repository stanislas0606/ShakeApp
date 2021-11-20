//
//  MainModel.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

final class MainModel {

    // MARK: - Properties
    private let storageDataProvider: StorageDataProvider
    private var networkDataProvider: NetworkDataProvider

    var fetchDataHandler: ((PresentableAnswerData) -> Void)?

    // MARK: - Init
    init(networkDataProvider: NetworkDataProvider, storageDataProvider: StorageDataProvider) {
        self.networkDataProvider = networkDataProvider
        self.storageDataProvider = storageDataProvider
        self.networkDataProvider.delegate = self
    }

    func loadData(for question: String) {
        networkDataProvider.loadData(for: question)
    }
}

extension MainModel: NetworkServiceDelegate {

    func didLoadData(_ data: AnswerData) {
        let answer = data.toPresentableAnswerData()
        fetchDataHandler?(answer)
    }

    func didGetError() {
        if let answer = storageDataProvider.readData(for: L10n.Answer.Custom.key) {
            fetchDataHandler?(PresentableAnswerData(with: answer))
        } else {
            fetchDataHandler?(PresentableAnswerData(with: L10n.Answer.Default.text))
        }
    }
}
