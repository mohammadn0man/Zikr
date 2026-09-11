import Foundation
import WatchKit

struct DoubleTapDetector {
    /// Double Tap requires watchOS 11+ AND Series 9 / Ultra 2 or newer hardware.
    static var isSupported: Bool {
        guard isWatchOS11OrLater else { return false }
        return isSupportedHardware
    }
    
    private static var isWatchOS11OrLater: Bool {
        if #available(watchOS 11, *) { return true }
        return false
    }
    
    /// Check device model identifier for Series 9+ or Ultra 2+ hardware.
    /// Watch7,1-Watch7,5 = Series 9 / Ultra 2
    /// Watch8,x and later = Series 10+ / Ultra 3+
    private static var isSupportedHardware: Bool {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let model = String(cString: machine)
        
        // Parse "WatchN,M" — N >= 7 means Series 9 / Ultra 2 or newer
        guard model.hasPrefix("Watch") else { return false }
        let numberPart = model.dropFirst(5)
        guard let commaIndex = numberPart.firstIndex(of: ","),
              let generation = Int(numberPart[numberPart.startIndex..<commaIndex]) else {
            return false
        }
        return generation >= 7
    }
}
