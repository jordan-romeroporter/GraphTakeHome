
import SwiftUI

struct PlainButton: View {
    private let buttonCornerRadius: CGFloat = 8
    
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Text(label)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .foregroundColor(isSelected ? .white : .gray)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.green : Color.clear)
                .cornerRadius(buttonCornerRadius)
        }
        .buttonStyle(.plain)
    }
}
