//
//  NetworkService.swift
//  ShakeApp
//
//  Created by Softermii-User on 21.10.2021.
//

import Foundation

protocol NetworkServiceDelegate {
    func didFetchMagic(_ networkService: NetworkService, _ magicData: MagicData)
    func didGetError()
}

struct NetworkService {
    
    //MARK: Properties
    
    let baseURL = URL(string: "https://8ball.delegator.com/magic/JSON/")
    
    var delegate: NetworkServiceDelegate?
    
    //MARK: Functions
    
    func fetchAnswer(for question: String) {
        guard let url = baseURL, !question.isEmpty else { return }
        let questionString = question.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(url)\(questionString)"
        performRequest(with: urlString)
    }
    
    //MARK: Private
    
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, responce, error in
            guard let data = data, let decodedData = parseJSON(data) else {
                DispatchQueue.main.async {
                    self.delegate?.didGetError()
                }
                return
            }
            DispatchQueue.main.async {
                self.delegate?.didFetchMagic(self, decodedData.magic)
            }
            
        }
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> AnswerData? {
        return try! JSONDecoder().decode(AnswerData.self, from: data)
    }
}
