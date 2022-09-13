import Foundation

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    
    let name: String
    let type: String
    let amount: Double
}
