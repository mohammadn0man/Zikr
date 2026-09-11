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
    @AppStorage("zikrCount") private var count = 0
    @StateObject private var sessionManager = SessionManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("\(count)")
                    .font(.system(size: 60, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    count += 1
                    WKInterfaceDevice.current().play(.click) // Added haptic feedback
                }) {
                    Text("Tap")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity, minHeight: 60)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .handGestureShortcut(.primaryAction)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        count = 0
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.body.bold())
                            .foregroundColor(.red)
                    }
                }
            }
            .onAppear {
                sessionManager.startSession()
            }
        }
    }
}

#Preview {
    ContentView()
}
