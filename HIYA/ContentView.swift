//
//  ContentView.swift
//  HIYA
//
//  Created by Guillaume Richard on 19/02/2026.
//

import FoundationModels
import SwiftUI

struct ContentView: View {
    private var largeLanguageModel = SystemLanguageModel.default
    @State private var response = ""
    @State private var isLoading = false
    private var session = LanguageModelSession()

    var body: some View {
        VStack {
            Spacer()
            switch largeLanguageModel.availability {
            case .available:
                if isLoading {
                    ProgressView().tint(.purple)
                } else if response.isEmpty {
                    ContentUnavailableView {
                        Label(
                            "Tap the button to get a fun response",
                            systemImage: "wand.and.sparkles"
                        )
                        .foregroundStyle(.tertiary)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .symbolEffect(.pulse)
                    }
                } else {
                    Text(response)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .bold()
                }
            case .unavailable(.deviceNotEligible):
                Text("Your device is not eligible for Apple Intelligence.")
            case .unavailable(.appleIntelligenceNotEnabled):
                Text("Please enable Apple Intelligence in Settings")
            case .unavailable(.modelNotReady):
                Text("The AI model is not ready.")
            case .unavailable(_):
                Text("The AI feature is unavailable for an unknown reason.")
            }
            Spacer()
            Button {
                Task {
                    // defer gurantees that it will be false when the current Task exists no matter what is the result.
                    // Peu importe que la requête réussise, échoue ou est annulée.
                    // Utile pour cleanup.
                    defer { isLoading = false }

                    isLoading = true

                    let prompt = "Say hi in a fun way."
                    do {
                        let replay = try await session.respond(to: prompt)
                        response = replay.content
                    } catch {
                        response =
                            "Failed to get response: \(error.localizedDescription)"
                    }
                }

            } label: {
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            .glassEffect(.regular.interactive())
        }
        .padding()
        .tint(.purple)
    }
}

#Preview {
    ContentView()
}
