import SwiftUI
import WatchKit

class SessionManager: NSObject, ObservableObject, WKExtendedRuntimeSessionDelegate {
    var session: WKExtendedRuntimeSession?
    
    func startSession() {
        if session == nil {
            session = WKExtendedRuntimeSession()
            session?.delegate = self
            session?.start()
        }
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("Extended runtime session started")
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("Extended runtime session expiring")
    }
    
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        print("Extended runtime session invalidated: \(reason.rawValue)")
        self.session = nil
    }
}

struct ContentView: View {
    @StateObject private var counter = ZikrCounter()
    @StateObject private var sessionManager = SessionManager()
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var showResetConfirmation = false
    
    var body: some View {
        NavigationStack {
            CounterView(counter: counter)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showResetConfirmation = true
                        }) {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.body.bold())
                                .foregroundColor(.red)
                        }
                    }
                }
        }
        .confirmationDialog(
            "Reset Counter?",
            isPresented: $showResetConfirmation,
            titleVisibility: .visible
        ) {
            Button("Reset to 0", role: .destructive) {
                counter.reset()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Your count of \(counter.count) will be lost.")
        }
        .sheet(isPresented: Binding(
            get: { !hasSeenOnboarding },
            set: { if !$0 { hasSeenOnboarding = true } }
        )) {
            OnboardingTipView(isDoubleTapSupported: DoubleTapDetector.isSupported)
        }
        .onAppear {
            sessionManager.startSession()
        }
    }
}

#Preview {
    ContentView()
}
