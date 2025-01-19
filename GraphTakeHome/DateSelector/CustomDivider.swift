import SwiftUI

struct CustomDivider: View {
    let height: CGFloat
    let opacity: Double
    
    var body: some View {
        VStack{
            Rectangle()
                .frame(height: height)
                .foregroundColor(.white.opacity(opacity))
                .frame(maxWidth: .infinity)
        }
    }
}
