//
//  NetworkService.swift
//  ShakeApp
//
//  Created by Softermii-User on 21.10.2021.
//

import Foundation

protocol NetworkServiceDelegate: AnyObject {
    func didLoadData(_ data: AnswerData)
    func didGetError()
}

protocol NetworkDataProvider {
    var delegate: NetworkServiceDelegate? { get set }
    func loadData(for question: String)
}

final class NetworkService: NetworkDataProvider {

    // MARK: - Properties
    let baseURL = URL(string: "https://8ball.delegator.com/magic/JSON/")

    weak var delegate: NetworkServiceDelegate?

    // MARK: - Functions
    func loadData(for question: String) {
        guard let url = baseURL, !question.isEmpty else { return }
        let questionString = question.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(url)\(questionString)"
        performRequest(with: urlString)
    }

    // MARK: - Private
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let decodedData = self?.parseJSON(data) else {
                self?.delegate?.didGetError()
                return
            }
            self?.delegate?.didLoadData(decodedData.toAnswerData())
            
        }
        task.resume()
    }

    private func parseJSON(_ data: Data) -> ManagedAnswerData? {
        do {
            return try JSONDecoder().decode(ManagedAnswerData.self, from: data)
        } catch {
            return nil
        }
    }
}
