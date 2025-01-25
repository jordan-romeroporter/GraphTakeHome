import SwiftUI

struct DateRangeButton: View {
    let date: DateSelector.DateRange
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        PlainButton(label: date.label, isSelected: isSelected, action: action)
    }
}
