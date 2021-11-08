//
//  AnswerData.swift
//  ShakeApp
//
//  Created by Softermii-User on 21.10.2021.
//

import Foundation

struct AnswerData: Codable {
    let magic: MagicData
}

struct MagicData: Codable{
    let question: String
    let answer: String
    let type: String
}
