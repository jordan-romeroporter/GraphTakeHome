import Foundation

protocol ChartEntryProtocol: Identifiable {
    var id: UUID { get }
}

struct BalanceEntry: Identifiable, Equatable {
    let id: UUID = UUID()
    let date: Date
    let balance: Double
    
    static func == (lhs: BalanceEntry, rhs: BalanceEntry) -> Bool {
        lhs.id == rhs.id && lhs.date == rhs.date && lhs.balance == rhs.balance
    }
}
