import SwiftUI
import WidgetKit

@main
struct Zikr_Watch_AppApp: App {
    
    init() {
        if #available(watchOS 10.0, *) {
            ZikrRelevanceManager.updateRelevance()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    // Widget tap → opens directly to counter
                    print("Opened from widget: \(url)")
                }
        }
    }
}
