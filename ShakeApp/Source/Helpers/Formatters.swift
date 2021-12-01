//
//  Formatters.swift
//  ShakeApp
//
//  Created by Softermii-User on 01.12.2021.
//

import Foundation

enum Formatters {
    enum Date {
        static let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            return formatter
        }()
    }
}
