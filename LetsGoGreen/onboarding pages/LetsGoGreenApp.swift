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
    @StateObject private var viewModel = EventViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
        .modelContainer(for: [Event.self, Participant.self])
    }
}
