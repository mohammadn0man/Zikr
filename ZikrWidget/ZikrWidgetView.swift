import SwiftUI
import WidgetKit

struct ZikrWidgetView: View {
    @Environment(\.widgetFamily) var family
    var entry: ZikrEntry
    
    var body: some View {
        switch family {
        case .accessoryRectangular:
            rectangularView
        case .accessoryCircular:
            circularView
        case .accessoryInline:
            inlineView
        default:
            rectangularView
        }
    }
    
    // MARK: - Smart Stack (primary)
    private var rectangularView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Label("Zikr", systemImage: "hands.and.sparkles.fill")
                    .font(.headline)
                    .foregroundStyle(.green)
                    .widgetAccentable()
                
                Text("Current count")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            Spacer(minLength: 8)
            
            Text("\(entry.count)")
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .monospacedDigit()
                .minimumScaleFactor(0.4)
                .lineLimit(1)
        }
        .widgetURL(URL(string: "zikr://counter"))
    }
    
    // MARK: - Circular complication
    private var circularView: some View {
        VStack(spacing: 1) {
            Image(systemName: "hands.and.sparkles.fill")
                .font(.caption)
                .widgetAccentable()
            
            Text("\(entry.count)")
                .font(.system(.body, design: .rounded).bold())
                .monospacedDigit()
                .minimumScaleFactor(0.4)
        }
        .widgetURL(URL(string: "zikr://counter"))
    }
    
    // MARK: - Inline complication
    private var inlineView: some View {
        Text("Zikr: \(entry.count)")
    }
}
