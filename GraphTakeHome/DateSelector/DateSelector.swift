import SwiftUI

struct DateSelector: View {
    @Binding var selectedDateRange: DateRange
    
    var body: some View {
        VStack(spacing:8){
            CustomDivider(height: 1, opacity: 0.3)
            HStack(spacing: 16) {
                ForEach(DateRange.allCases, id: \.self) { dateRange in
                    DateRangeButton(
                        date: dateRange,
                        isSelected: selectedDateRange == dateRange,
                        action: { selectedDateRange = dateRange }
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16.0)
            .padding(.bottom, 8)
        }
    }
}

extension DateSelector {
    enum DateRange: Int, CaseIterable {
        case oneMonth = 1
        case threeMonths = 3
        case sixMonths = 6
        case oneYear = 12
        case allTime = 0
        
        var label: String {
            switch self {
            case .oneMonth: return "1M"
            case .threeMonths: return "3M"
            case .sixMonths: return "6M"
            case .oneYear: return "1Y"
            case .allTime: return "ALL"
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedDateRange = DateSelector.DateRange.oneMonth
    
    DateSelector(selectedDateRange: $selectedDateRange)
        .frame(width: 400)
}
