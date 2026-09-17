import AppIntents
import WidgetKit

struct ZikrWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Zikr Counter"
    static var description = IntentDescription("Shows your current dhikr count.")
}
