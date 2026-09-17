import SwiftUI
import WatchKit

struct CounterView: View {
    @ObservedObject var counter: ZikrCounter
    @State private var crownAccumulator: Double = 0.0
    @State private var lastProcessedCrown: Double = 0.0
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text("\(counter.count)")
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .monospacedDigit()
                .contentTransition(.numericText())
                .animation(isLuminanceReduced ? nil : .snappy, value: counter.count)
            
            Spacer()
            
            if !isLuminanceReduced {
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
        .focusable()
        .digitalCrownRotation(
            $crownAccumulator,
            from: -1000000.0,
            through: 1000000.0,
            by: 2, // Syncs system detent haptic with our threshold
            sensitivity: .low, // Requires deliberate physical turn
            isContinuous: false,
            isHapticFeedbackEnabled: true
        )
        .onChange(of: crownAccumulator) { _, newValue in
            let threshold = 2.0 // Must match the 'by' parameter above
            let delta = newValue - lastProcessedCrown
            
            if abs(delta) >= threshold {
                // CRITICAL FIX: Only ever increment by 1, regardless of how huge the jump is!
                // This completely destroys the OS velocity acceleration, forcing a static physical feel.
                counter.increment()
                
                // Snap baseline to current value, throwing away any excess "accelerated" value.
                lastProcessedCrown = newValue
            }
        }
    }
}
