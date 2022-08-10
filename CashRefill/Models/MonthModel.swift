//
//  MonthModel.swift
//  CashRefill
//
//  Created by Woturios on 10/07/2022.
//

import Foundation

struct Month: Identifiable {
    let id = UUID()
    let piggyID: UUID
    let title: String
    let items: [PostEntity]
    let price: Double
    let date: Date
}

struct FilteredMonth: Identifiable {
    let id = UUID()
    let piggyID: UUID
    let title: String
    let items: [PostEntity]
    let price: Double
    let date: Date
}
