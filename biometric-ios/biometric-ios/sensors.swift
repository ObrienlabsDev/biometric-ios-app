//
//  sensors.swift
//  biometric-ios
//
//  Created by Michael O'Brien on 2025/9/22.
//

import Foundation

struct SensorData: Codable {
    let deviceId: String
    let temperature: Double
    let humidity: Double
    let timestamp: Date
}


// 2. Create a function to send the data
func sendSensorData(data: SensorData) async {
    guard let url = URL(string: "http://local.obrienlabs.io:8889/nbi/api/latest?user=20250921")// "https://obrienlabs.dev")///api/sensor")
    else {
        print("Error: Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601 // Standard date format
    
    do {
        let jsonData = try encoder.encode(data)
        request.httpBody = jsonData
        
        // URLSession automatically handles HTTP/3 negotiation on supported OS versions.
        let (responseData, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Error: Invalid response from server")
            return
        }
        
        if let responseString = String(data: responseData, encoding: .utf8) {
            print("✅ Success! Server response: \(responseString)")
        }
    } catch {
        print("❌ Error sending data: \(error.localizedDescription)")
    }
}


