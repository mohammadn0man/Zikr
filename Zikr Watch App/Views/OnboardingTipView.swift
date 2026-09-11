import SwiftUI

struct OnboardingTipView: View {
    let isDoubleTapSupported: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Image(systemName: "hand.tap.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(.green)
                
                Text("Welcome to Zikr")
                    .font(.headline)
                
                // Input methods
                VStack(alignment: .leading, spacing: 8) {
                    Label("Tap the button to count", systemImage: "hand.point.up.fill")
                        .font(.caption)
                    
                    Label("Rotate the Crown to count", systemImage: "digitalcrown.horizontal.arrow.counterclockwise.fill")
                        .font(.caption)
                    
                    if isDoubleTapSupported {
                        Label("Double Tap gesture to count", systemImage: "hand.tap.fill")
                            .font(.caption)
                    }
                }
                .foregroundStyle(.secondary)
                
                // Wrist detection tip
                Divider()
                
                Text("💡 Using handheld? If your watch locks when removed from your wrist, go to Settings → Passcode → Wrist Detection on your watch to adjust.")
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.tertiary)
                
                if !isDoubleTapSupported {
                    Text("Double Tap requires Series 9 / Ultra 2+ with watchOS 11+.")
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.tertiary)
                }
                
                Button("Got it") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .padding(.top, 4)
            }
            .padding()
        }
    }
}
