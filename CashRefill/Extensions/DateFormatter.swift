//
//  DateFormatter.swift
//  CashRefill
//
//  Created by Woturios on 29/06/2022.
//

import Foundation

extension DateFormatter {
    static let displayDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
}
