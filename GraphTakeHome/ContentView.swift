

import SwiftUI
import Charts

struct ContentView: View {
    @State private var numbers = (0...10)
        .map { _ in Int.random(in: 0...10) }
    @State private var selectedDate = DateSelector.DateRange.oneMonth
    
    var body: some View {
        VStack {
            Chart {
                ForEach(Array(numbers.enumerated()), id: \.element) { index, number in
                    LineMark(
                        x: .value("index", index),
                        y: .value("value", number)
                    )
                    
                    PointMark(
                        x: .value("index", index),
                        y: .value("value", number)
                    )
                }
            }
            DateSelector(selectedDate: $selectedDate)
        }
    }
}

#Preview {
    ContentView()
}
