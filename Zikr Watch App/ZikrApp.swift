import SwiftUI

@main
struct Zikr_Watch_AppApp: App {
    
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
