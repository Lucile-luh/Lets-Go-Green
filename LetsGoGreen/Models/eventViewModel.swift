//
//  eventViewModel.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 31/10/2025.
//

import Foundation
internal import Combine

@MainActor
class EventViewModel: ObservableObject {
    // Holds event data shared between views when needed.
    @Published var events: [Event] = []
    
    // Returns the events scheduled on the selected calendar day.
    func events(for date: Date) -> [Event] {
        let calendar = Calendar.current
        return events.filter { calendar.isDate($0.date, inSameDayAs: date) }
    }
}
