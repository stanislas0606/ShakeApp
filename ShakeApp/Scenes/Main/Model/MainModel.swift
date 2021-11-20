//
//  MainModel.swift
//  ShakeApp
//
//  Created by Softermii-User on 14.11.2021.
//

import Foundation

class MainModel {

    // MARK: - Properties
    private let storageDataProvider: StorageDataProvider
    private var networkDataProvider: NetworkDataProvider
    private var answerData: String?

    var fetchDataHandler: ((String) -> Void)?

    // MARK: - Init
    init(networkDataProvider: NetworkDataProvider, storageDataProvider: StorageDataProvider) {
        self.networkDataProvider = networkDataProvider
        self.storageDataProvider = storageDataProvider
        self.networkDataProvider.delegate = self
    }

    func fetchData(for question: String) {
        networkDataProvider.loadData(for: question)
    }

    func getAnswer() -> String {
        guard let answer = answerData else {
            return L10n.Answer.Default.text
        }
        return answer
    }
}

extension MainModel: NetworkServiceDelegate {

    func didFetchData(_ data: AnswerData) {
        answerData = data.answer
        guard let answer = answerData else { return }
        fetchDataHandler?(answer)
    }

    func didGetError() {
        answerData = storageDataProvider.readData(for: L10n.Answer.Custom.key)
        if let answer = answerData {
            fetchDataHandler?(answer)
        } else {
            fetchDataHandler?(L10n.Answer.Default.text)
        }
    }
}
