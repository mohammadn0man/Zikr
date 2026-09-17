import AppIntents
import WidgetKit

@available(watchOS 10.0, *)
struct ZikrRelevanceManager {
    
    /// Donates prayer-time relevance hints to the system.
    /// Call this on every app launch and when count changes significantly.
    static func updateRelevance() {
        Task {
            let prayerWindows: [(String, Int, Int, Int, Int)] = [
                // (name, startHour, startMin, endHour, endMin)
                ("Fajr",    4, 30,  6,  0),
                ("Dhuhr",  12,  0, 13, 30),
                ("Asr",    15, 30, 17,  0),
                ("Maghrib",18,  0, 19, 30),
                ("Isha",   20,  0, 22,  0),
            ]
            
            let calendar = Calendar.current
            let now = Date()
            
            var intents: [RelevantIntent] = []
            
            for (_, sh, sm, eh, em) in prayerWindows {
                guard let startToday = calendar.date(bySettingHour: sh, minute: sm, second: 0, of: now),
                      let endToday = calendar.date(bySettingHour: eh, minute: em, second: 0, of: now) else { continue }
                
                if endToday > now {
                    intents.append(RelevantIntent(
                        ZikrWidgetIntent(),
                        widgetKind: "ZikrWidget",
                        relevance: .date(from: startToday, to: endToday)
                    ))
                }
                
                if let startTomorrow = calendar.date(byAdding: .day, value: 1, to: startToday),
                   let endTomorrow = calendar.date(byAdding: .day, value: 1, to: endToday) {
                    intents.append(RelevantIntent(
                        ZikrWidgetIntent(),
                        widgetKind: "ZikrWidget",
                        relevance: .date(from: startTomorrow, to: endTomorrow)
                    ))
                }
            }
            
            do {
                try await RelevantIntentManager.shared.updateRelevantIntents(intents)
            } catch {
                print("Failed to update relevance: \(error)")
            }
        }
    }
}
