import SwiftUI
import Charts
import Foundation

struct BalanceChart: View {
    @Binding var selectedDateRange: DateSelector.DateRange
    @Binding var balanceData: [BalanceEntry]
    @Binding var selectedDate: Date?
    @Binding var selectedBalance: Double?
    
    var filteredBalanceData: [BalanceEntry] {
        balanceData.filtered(by: selectedDateRange)
    }
    
    var body: some View {
        GeometryReader { geometry in
            Chart {
                ForEach(filteredBalanceData) { entry in
                    LineMark(
                        x: .value("Date", entry.date),
                        y: .value("Balance", entry.balance)
                    )
                }
                
                if let selectedDate = selectedDate {
                    RuleMark(x: .value("Selected", selectedDate))
                        .foregroundStyle(.gray.opacity(0.3))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
                }
            }
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
            .animation(nil, value: filteredBalanceData)
            .gesture(
                LongPressGesture(minimumDuration: 0.1)
                    .sequenced(before: DragGesture(minimumDistance: 0))
                    .onChanged { value in
                        switch value {
                        case .second(true, let drag):
                            if let drag = drag {
                                updateSelection(at: drag.location, in: geometry.frame(in: .local))
                            }
                        default:
                            break
                        }
                    }
                    .onEnded { _ in
                        let mostRecentBalanceData = balanceData.last ?? nil
                        selectedDate = mostRecentBalanceData?.date ?? nil
                        selectedBalance = mostRecentBalanceData?.balance ?? nil
                    }
            )
        }
    }
    
    private func updateSelection(at location: CGPoint, in frame: CGRect) {
        guard !filteredBalanceData.isEmpty else { return }
        
        let xPosition = location.x
        let totalWidth = frame.width
        let pointWidth = totalWidth / CGFloat(filteredBalanceData.count - 1)
        
        let index = Int(round(xPosition / pointWidth))
        let safeIndex = max(0, min(filteredBalanceData.count - 1, index))
        
        let selectedEntry = filteredBalanceData[safeIndex]
        selectedDate = selectedEntry.date
        selectedBalance = selectedEntry.balance
    }
}

#Preview ("ChartView"){
    @Previewable @State var selectedDateRange: DateSelector.DateRange = .oneMonth
    @Previewable @State var balanceData: [BalanceEntry] = BalanceDataGenerator.generateDailyBalances(from: Calendar.current.date(byAdding: .day, value: -45, to: Date())!, initialBalance: 15000.0)
    @Previewable @State var selectedDate: Date? = nil
    @Previewable @State var selectedBalance: Double? = nil
    
    HStack {
        BalanceChart(selectedDateRange: $selectedDateRange, balanceData: $balanceData, selectedDate: $selectedDate, selectedBalance: $selectedBalance)
            .padding(.horizontal, 16)
    }
}
