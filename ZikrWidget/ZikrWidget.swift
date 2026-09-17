import WidgetKit
import SwiftUI

// MARK: - Timeline Entry
struct ZikrEntry: TimelineEntry {
    let date: Date
    let count: Int
    let relevance: TimelineEntryRelevance?
}

// MARK: - Timeline Provider
struct ZikrTimelineProvider: AppIntentTimelineProvider {
    private let appGroupID = "group.mohammadn0man.zikrcounter.data"
    private let countKey = "zikrCount"
    
    private func currentCount() -> Int {
        UserDefaults(suiteName: appGroupID)?.integer(forKey: countKey) ?? 0
    }
    
    func placeholder(in context: Context) -> ZikrEntry {
        ZikrEntry(date: .now, count: 33, relevance: nil)
    }
    
    func snapshot(for configuration: ZikrWidgetIntent,
                  in context: Context) async -> ZikrEntry {
        ZikrEntry(date: .now, count: currentCount(), relevance: nil)
    }
    
    func timeline(for configuration: ZikrWidgetIntent,
                  in context: Context) async -> Timeline<ZikrEntry> {
        let count = currentCount()
        
        // "Now" entry with moderate relevance (30 min duration)
        let now = ZikrEntry(
            date: .now,
            count: count,
            relevance: TimelineEntryRelevance(score: 0.5, duration: 1800)
        )
        
        // .never policy — we manually trigger reloads from the main app
        return Timeline(entries: [now], policy: .never)
    }
    
    func recommendations() -> [AppIntentRecommendation<ZikrWidgetIntent>] {
        [AppIntentRecommendation(intent: ZikrWidgetIntent(), description: "Zikr Counter")]
    }
}

// MARK: - Widget Definition
struct ZikrWidget: Widget {
    let kind = "ZikrWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ZikrWidgetIntent.self,
            provider: ZikrTimelineProvider()
        ) { entry in
            ZikrWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Zikr Counter")
        .description("See your current dhikr count at a glance.")
        .supportedFamilies([
            .accessoryRectangular,
            .accessoryCircular,
            .accessoryInline
        ])
    }
}
