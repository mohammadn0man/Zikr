import WidgetKit
import SwiftUI

// MARK: - Timeline Entry
struct ZikrEntry: TimelineEntry {
    let date: Date
    let count: Int
}

// MARK: - Timeline Provider
struct ZikrTimelineProvider: TimelineProvider {
    private let appGroupID = "group.com.mohammadnoman.zikr"
    private let countKey = "zikrCount"
    
    private func currentCount() -> Int {
        UserDefaults(suiteName: appGroupID)?.integer(forKey: countKey) ?? 0
    }
    
    func placeholder(in context: Context) -> ZikrEntry {
        ZikrEntry(date: .now, count: 33)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ZikrEntry) -> Void) {
        completion(ZikrEntry(date: .now, count: currentCount()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ZikrEntry>) -> Void) {
        let entry = ZikrEntry(date: .now, count: currentCount())
        // .never policy — we manually trigger reloads from the main app
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

// MARK: - Widget Definition
struct ZikrWidget: Widget {
    let kind = "ZikrWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ZikrTimelineProvider()) { entry in
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
