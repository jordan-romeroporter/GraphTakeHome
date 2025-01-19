import SwiftUI

struct DateSelector: View {
    @Binding var selectedDate: DateRange
    
    var body: some View {
        VStack{
            CustomDivider(height: 1, opacity: 0.3)
            HStack(spacing: 10) {
                ForEach(DateRange.allCases, id: \.self) { date in
                    DateRangeButton(
                        date: date,
                        isSelected: selectedDate == date,
                        action: { selectedDate = date }
                    )
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

extension DateSelector {
    enum DateRange: String, CaseIterable {
        case oneMonth = "1M"
        case threeMonths = "3M"
        case sixMonths = "6M"
        case oneYear = "1Y"
        case allTime = "ALL"
    }
}

struct DateSelectorPreview: View {
    @State private var selectedDate = DateSelector.DateRange.oneMonth
    
    var body: some View {
        DateSelector(selectedDate: $selectedDate)
            .frame(width: 400)
    }
}

#Preview {
    DateSelectorPreview()
}
