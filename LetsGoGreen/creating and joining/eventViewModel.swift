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
    
    @Published var events: [Event] = []
    
//    init() {
//        
//    }
    func events(for date: Date) -> [Event] {
            let calendar = Calendar.current
            return events.filter { calendar.isDate($0.date, inSameDayAs: date) }
        }
}
