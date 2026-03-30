//
//  LetsGoGreenApp.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI
import SwiftData

@main
struct LetsGoGreenApp: App {
    // Shares event data across views that need calendar-related state.
    @StateObject private var viewModel = EventViewModel()
    
    var body: some Scene {
        WindowGroup {
            // Sets up the content view and injects shared dependencies.
            ContentView()
                .environmentObject(viewModel)
        }
        .modelContainer(for: [Event.self, Participant.self])
    }
}
