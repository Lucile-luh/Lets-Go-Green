//
//  EventStore.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 27/10/2025.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Event: Identifiable{
    var title: String
    var date: Date
    var location: String
    var time: Date
    var info: String
    
    init(title: String, date: Date, location: String, time: Date, info: String) {
        self.title = title
        self.date = date
        self.location = location
        self.time = time
        self.info = info
    }

    var scheduledAt: Date {
        let calendar = Calendar.current
        let eventDay = calendar.dateComponents([.year, .month, .day], from: date)
        let eventTime = calendar.dateComponents([.hour, .minute], from: time)
        return calendar.date(
            from: DateComponents(
                year: eventDay.year,
                month: eventDay.month,
                day: eventDay.day,
                hour: eventTime.hour,
                minute: eventTime.minute
            )
        ) ?? date
    }
}

