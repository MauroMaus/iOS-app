import SwiftUI
import ActivityKit

struct ContentView: View {
    
    @State var timerIsRunning: Bool = false
    @State var timerStartTime: Date? = nil
    @State var timerActivity: Activity<TimerAttributes>? = nil
    
    func timerStart() {
        // Do nothing if timer is running
        if timerIsRunning {
            return
        }
        // Set running and start time to now
        timerIsRunning = true
        timerStartTime = .now
        
        // Start timer activity
        let timerAttributes = TimerAttributes()
        let timerState = TimerAttributes.ContentState(startTime: timerStartTime!, eventDescription: "Timer was started")
        let timerContent = ActivityContent(
            state: timerState,
            staleDate: nil
        )
        
        timerActivity =
        try! Activity.request(
            attributes: timerAttributes,
            content: timerContent,
            pushType: nil
        )
    }
    
    func timerStop() {
        // Do nothing if timer not running
        if (!timerIsRunning) {
            return
        }
        // Set stopped
        timerIsRunning = false
        
        // End activity
        guard let timerStartTime else {return}
        let timerState = TimerAttributes.ContentState(
            startTime: timerStartTime,
            eventDescription: "Timer was stopped"
        )
        
        Task {
            await timerActivity?.end(
                ActivityContent(state: timerState, staleDate: nil),dismissalPolicy: .immediate)
        }
        
        // Set start time to nil
        self.timerStartTime = nil
    }
    
    func timerEvent() {
        // Do nothing if timer not running
        if (!timerIsRunning) {
            return
        }
        // "Travel in time" (add 5 minutes to the timer)
        timerStartTime = timerStartTime?.addingTimeInterval(-300)
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                // Timer entry
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        Image(systemName: "stopwatch")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                        
                        Text("Timer")
                            .font(.title2.monospaced())
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        // TIMER CONTROLS
                        HStack {
                            Button(action: timerStart) {
                                Image(systemName: "play.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(timerIsRunning ? .gray : .green)
                            }
                            
                            Button(action: timerEvent) {
                                Image(systemName: "arrow.up.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(timerIsRunning ? .purple : .gray)
                            }
                            
                            Button(action: timerStop) {
                                Image(systemName: "stop.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(timerIsRunning ? .red : .gray)
                            }
                        }
                        .padding(.vertical, 10)
                        
                        Spacer()
                    }
                    
                    // View that displays timer in a circle
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 3)
                            .foregroundColor(Color.gray)
                            .frame(width: 150, height: 150)
                        
                        // Try unwrapping startTime
                        if let timerStartTime {
                            Text(timerStartTime, style: .timer)
                                .font(.title.monospaced())
                        } else {
                            Text("0:00")
                                .font(.title.monospaced())
                        }
                    }
                }
                
                Spacer()
                
                // Delivery entry
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        Image(systemName: "takeoutbag.and.cup.and.straw")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                        
                        Text("Delivery")
                            .font(.title2.monospaced())
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        // DELIVERY CONTROLS
                        HStack {
                            Button(action: {print("Timer Start")}) {
                                Image(systemName: "play.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(timerIsRunning ? .gray : .green)
                            }
                            
                            Button(action: {print("Timer update")}) {
                                Image(systemName: "arrow.up.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(timerIsRunning ? .purple : .gray)
                            }
                            
                            Button(action: {print("Timer stop")}) {
                                Image(systemName: "stop.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(timerIsRunning ? .red : .gray)
                            }
                        }
                        .padding(.vertical, 10)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
            }
            .navigationTitle("ActivityKit Demo")
        }
    }
}

#Preview {
    ContentView()
}
