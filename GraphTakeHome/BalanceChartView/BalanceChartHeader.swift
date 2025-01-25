import SwiftUI

struct BalanceChartHeader: View {
    @Binding var selectedDate: Date?
    @Binding var selectedBalance: Double?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("TOTAL BALANCE")
                .foregroundStyle(.secondary);
            Text(currencyFormatter.string(from: NSNumber(value: selectedBalance ?? 0)) ?? "$0.00")
                .font(.system(size: 28, weight: .bold))
            
            Text(dateFormatter.string(from: selectedDate ?? Date()))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    @Previewable @State var selectedDate: Date?
    @Previewable @State var selectedBalance: Double?
    
    BalanceChartHeader(selectedDate: $selectedDate, selectedBalance: $selectedBalance)
}
