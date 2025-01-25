import Foundation

struct BalanceDataGenerator {
    static func generateDailyBalances(from startDate: Date, initialBalance: Double = 10000.0) -> [BalanceEntry] {
        let calendar = Calendar.current
        let endDate = Date()
        var entries: [BalanceEntry] = []
        var currentDate = startDate
        var currentBalance = initialBalance
        
        while currentDate <= endDate {
            // Generate a daily percentage change between -2% and +10%
            let percentageChange = Double.random(in: -0.1...0.1)
            
            
            entries.append(BalanceEntry(
                date: calendar.startOfDay(for: currentDate),
                balance: currentBalance
            ))
            
            currentBalance += currentBalance * percentageChange
            
            if let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDay
            } else {
                break
            }
        }
        
        return entries
    }
    
    static func getStartDate(for period: DateSelector.DateRange, accountCreationDate: Date) -> Date {
        let calendar = Calendar.current
        let today = Date()
        
        switch period {
        case .oneMonth, .threeMonths, .sixMonths, .oneYear:
            return calendar.date(byAdding: .month, value: -(period.rawValue), to: today)!
        case .allTime:
            return accountCreationDate
        }
    }
}
