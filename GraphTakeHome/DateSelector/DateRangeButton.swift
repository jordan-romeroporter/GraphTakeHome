import SwiftUI

struct DateRangeButton: View {
    let date: DateSelector.DateRange
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Text(date.rawValue)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .foregroundColor(isSelected ? .white : .gray)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}
