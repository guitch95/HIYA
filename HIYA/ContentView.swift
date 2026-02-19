//
//  ContentView.swift
//  HIYA
//
//  Created by Guillaume Richard on 19/02/2026.
//

import SwiftUI
import FoundationModels

struct ContentView: View {
    private var largeLanguageModel = SystemLanguageModel.default
    @State private var response = ""
    var body: some View {
        VStack {
            switch largeLanguageModel.availability {
            case .available:
                Text(response)
            case .unavailable(.deviceNotEligible):
                Text("Your device is not eligible for Apple Intelligence.")
            case .unavailable(.appleIntelligenceNotEnabled):
                Text("Please enable Apple Intelligence in Settings")
            case .unavailable(.modelNotReady):
                Text("The AI model is not ready.")
            case .unavailable(_):
                Text("The AI feature is unavailable for an unknown reason.")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
