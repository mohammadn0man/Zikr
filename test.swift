import Foundation
import AppIntents

func foo() {
    let start = Date()
    let end = start.addingTimeInterval(10)
    let _ = RelevantContext.date(interval: DateInterval(start: start, end: end), kind: .default)
}
