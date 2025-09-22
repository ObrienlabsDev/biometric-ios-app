//
//  ContentView.swift
//  biometric-ios
//
//  Created by Michael O'Brien on 3/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("sending sensor data")
        }
        .onAppear {
            // This code runs when the view first appears on screen.
            // example
            let sampleData = SensorData(
                deviceId: "sensor-alpha-001",
                temperature: 23.5,
                humidity: 45.2,
                timestamp: Date()
            )
            //.padding()
            
            Task {
                await sendSensorData(data: sampleData)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
