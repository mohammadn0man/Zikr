import SwiftUI
import WatchKit

@MainActor
class ZikrCounter: ObservableObject {
    @AppStorage("zikrCount") var count: Int = 0
    
    func increment() {
        count += 1
        WKInterfaceDevice.current().play(.click)
    }
    
    func reset() {
        count = 0
        WKInterfaceDevice.current().play(.success)
    }
}
