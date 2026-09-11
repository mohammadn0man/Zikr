import SwiftUI

struct OnboardingTipView: View {
    let isDoubleTapSupported: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(systemName: "hand.tap.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.green)
                
                Text("Welcome to Zikr")
                    .font(.headline)
                
                if isDoubleTapSupported {
                    Text("Tap your thumb and index finger together twice to count — no need to look at your watch.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    
                    Text("You can also tap the button on screen.")
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.tertiary)
                } else {
                    Text("Tap the button on screen to count your dhikr.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    
                    Text("Double Tap gesture requires Apple Watch Series 9 or Ultra 2 and later with watchOS 11+.")
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.tertiary)
                }
                
                Button("Got it") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            .padding()
        }
    }
}
