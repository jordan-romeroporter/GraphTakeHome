import SwiftUI
import Charts

struct BalanceChartView: View {
    @State var selectedDate:Date  = Date()
    @State var selectedDateRange = DateSelector.DateRange.oneMonth
    @State var selectedBalance: Double? = nil
    @State var balanceData: [BalanceEntry] = BalanceDataGenerator.generateDailyBalances(from: Calendar.current.date(byAdding: .day, value: -45, to: Date())!, initialBalance: 15000.0)
    
    init() {
        _selectedBalance = State(initialValue: balanceData.last?.balance)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                ChartView {
                    BalanceChart(selectedDateRange: $selectedDateRange,
                               balanceData: $balanceData,
                               selectedDate: Binding(
                                   get: { selectedDate },
                                   set: { selectedDate = $0 ?? Date() }
                               ),
                               selectedBalance: $selectedBalance)
                } footer: {
                    DateSelector(selectedDateRange: $selectedDateRange)
                } header: {
                    BalanceChartHeader(selectedDate: Binding(
                        get: { selectedDate },
                        set: { selectedDate = $0 ?? Date() }
                    ), selectedBalance: $selectedBalance)
                }
                .frame(minHeight: 300, maxHeight: 300)
                
                VStack(spacing: 16) {
                    ForEach(1...10, id: \.self) { _ in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Lorem ipsum dolor sit amet")
                                .font(.headline)
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                                .font(.body)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
        .refreshable {
            let randomDays = Int.random(in: -365...(-30))
            balanceData = BalanceDataGenerator.generateDailyBalances(from: Calendar.current.date(byAdding: .day, value: randomDays, to: Date())!, initialBalance: 15000.0)
            selectedBalance = balanceData.last?.balance
        }
    }
}

#Preview {
    NavigationStack {
        BalanceChartView()
    }
}
