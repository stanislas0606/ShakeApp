//
//  NetworkService.swift
//  ShakeApp
//
//  Created by Softermii-User on 21.10.2021.
//

import Foundation

protocol NetworkServiceDelegate: AnyObject {
    func didFetchMagic(_ magicData: MagicData)
    func didGetError()
}

protocol NetworkDataProvider {
    var delegate: NetworkServiceDelegate? { get set }
    func fetchData(for question: String)
}

class NetworkService: NetworkDataProvider {

    // MARK: - Properties
    let baseURL = URL(string: "https://8ball.delegator.com/magic/JSON/")

    weak var delegate: NetworkServiceDelegate?

    // MARK: - Functions
    func fetchData(for question: String) {
        guard let url = baseURL, !question.isEmpty else { return }
        let questionString = question.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(url)\(questionString)"
        performRequest(with: urlString)
    }

    // MARK: - Private
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let decodedData = self?.parseJSON(data) else {
                DispatchQueue.main.async {
                    self?.delegate?.didGetError()
                }
                return
            }
            DispatchQueue.main.async {
                self?.delegate?.didFetchMagic(decodedData.magic)
            }
        }
        task.resume()
    }

    private func parseJSON(_ data: Data) -> AnswerData? {
        do {
            return try JSONDecoder().decode(AnswerData.self, from: data)
        } catch {
            return nil
        }
    }
}
