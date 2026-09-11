import SwiftUI
import WatchKit

struct CounterView: View {
    @ObservedObject var counter: ZikrCounter
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text("\(counter.count)")
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .monospacedDigit()
                .contentTransition(.numericText())
                .animation(.snappy, value: counter.count)
            
            Spacer()
            
            Button(action: {
                counter.increment()
            }) {
                Text("Tap")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity, minHeight: 60)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .handGestureShortcut(.primaryAction)
        }
    }
}
