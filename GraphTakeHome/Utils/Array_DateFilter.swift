import Foundation

extension Array where Element == BalanceEntry {
    func filtered(by dateRange: DateSelector.DateRange) -> [BalanceEntry] {
        guard !isEmpty else { return [] }
        
        let calendar = Calendar.current
        let today = Date()
        
        if dateRange == .allTime {
            return self
        }
        
        let monthsToSubtract = -dateRange.rawValue
        guard let targetStartDate = calendar.date(byAdding: .month, value: monthsToSubtract, to: today) else {
            return self
        }
        
        guard let earliestDataDate = self.map({ $0.date }).min() else {
            return self
        }
        
        if targetStartDate < earliestDataDate {
            var paddedEntries: [BalanceEntry] = []
            var currentDate = targetStartDate
            
            // Start padding with 0 balance
            while currentDate < earliestDataDate {
                paddedEntries.append(BalanceEntry(date: currentDate, balance: 0))
                if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                    currentDate = nextDate
                }
            }
            
            return paddedEntries + self.filter { $0.date >= earliestDataDate }
        }
        
        return self.filter { $0.date >= targetStartDate }
    }
}
