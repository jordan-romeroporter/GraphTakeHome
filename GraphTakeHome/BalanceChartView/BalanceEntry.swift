import Foundation

protocol ChartEntryProtocol: Identifiable {
    var id: UUID { get }
}

struct BalanceEntry: ChartEntryProtocol {
    let id = UUID()
    let date: Date
    let balance: Double
}
