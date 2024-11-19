import Foundation
import ActivityKit

struct TimerAttributes: ActivityAttributes {
    // Sets typealias for ContentState
    public typealias TimerStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var startTime: Date
        var eventDescription: String
    }
}
