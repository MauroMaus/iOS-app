//
//  TimerWidgetLiveActivity.swift
//  TimerWidget
//
//  Created by iOS on 17.11.24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TimerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                    Text(context.state.startTime, style: .timer)
                    .frame(maxWidth: 50, maxHeight: .infinity, alignment: .trailing)
                    .padding(.leading, 5)
                    .cornerRadius(44)
            } compactTrailing: {
                Image(systemName: "stopwatch")
                    .padding(.all, 5)
                    .cornerRadius(44)
            } minimal: {
                Image(systemName: "stopwatch")
                    .padding(.all, 5)
                    .cornerRadius(44)
            }
        }
    }
}
