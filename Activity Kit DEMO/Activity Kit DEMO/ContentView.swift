//
//  ContentView.swift
//  Activity Kit DEMO
//
//  Created by Fadi Al Eliwi on 07.11.24.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(hex: "30343F")
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                HeaderBanner()
                
                Spacer()
                
                VStack(spacing: 40) {
                    ActivityRow(activityName: "Activity 1")
                    ActivityRow(activityName: "Activity 2")
                    ActivityRow(activityName: "Activity 3")
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct HeaderBanner: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "FF6700"), Color(hex: "004E98")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 100)
            .cornerRadius(15)
            .padding(.horizontal)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            HStack {
                Image(systemName: "sparkles") // DEMO Icon (REPLACE)
                    .font(.system(size: 30))
                    .foregroundColor(Color(hex: "EBEBEB"))
                
                Text("Activity Kit DEMO")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "EBEBEB"))
            }
        }
        .padding(.top, 20)
    }
}

struct ActivityRow: View {
    let activityName: String
    
    var body: some View {
        HStack {
            Image(systemName: "app.badge.fill") // Placeholder für Activity Kit icon
                .font(.system(size: 30))
                .foregroundColor(Color(hex: "FF6700"))
                .padding(.trailing, 8)
            
            Text(activityName)
                .font(.title2)
                .foregroundColor(Color(hex: "EBEBEB"))
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: startActivity) {
                    Label("Start", systemImage: "play.circle.fill")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 30))
                        .foregroundColor(Color(hex: "3A6EA5"))
                }
                
                Button(action: updateActivity) {
                    Label("Update", systemImage: "arrow.triangle.2.circlepath.circle.fill")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 30))
                        .foregroundColor(Color(hex: "004E98"))
                }
                
                Button(action: endActivity) {
                    Label("End", systemImage: "stop.circle.fill")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                }
            }
        }
        .padding() // C0C0C0
        .background(Color(hex: "30343F").opacity(1))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
    
    func startActivity() {

    }
    
    func updateActivity() {

    }
    
    func endActivity() {

    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    ContentView()
}
