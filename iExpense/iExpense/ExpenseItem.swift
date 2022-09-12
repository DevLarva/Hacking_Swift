//
//  ExpenseItem.swift
//  iExpense
//
//  Created by 백대홍 on 2022/09/12.
//

import Foundation

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    
    let name: String
    let type: String
    let amount: Double
}
