import SwiftUI
import WatchKit
import WidgetKit

@MainActor
class ZikrCounter: ObservableObject {
    static let appGroupID = "group.com.mohammadnoman.zikr"
    static let countKey = "zikrCount"
    
    @Published var count: Int {
        didSet {
            // Persist to shared App Group storage
            Self.sharedDefaults?.set(count, forKey: Self.countKey)
            // Tell the widget to refresh
            WidgetCenter.shared.reloadTimelines(ofKind: "ZikrWidget")
        }
    }
    
    static var sharedDefaults: UserDefaults? {
        UserDefaults(suiteName: appGroupID)
    }
    
    init() {
        // Load from shared storage (falls back to 0)
        self.count = Self.sharedDefaults?.integer(forKey: Self.countKey) ?? 0
    }
    
    func increment() {
        count += 1
        WKInterfaceDevice.current().play(.click)
    }
    
    func reset() {
        count = 0
        WKInterfaceDevice.current().play(.success)
    }
}
