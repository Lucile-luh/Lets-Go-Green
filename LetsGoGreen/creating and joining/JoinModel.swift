//
//  JoinModel.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 31/10/2025.
//

import Foundation
import SwiftData

@Model
class Participant: Identifiable {
    var name: String
    var email: String
    var phone: String
    var eventTitle: String
    var joinedAt: Date
    var userID: String?
    var userEmail: String?

    init(
        name: String,
        email: String,
        phone: String,
        eventTitle: String,
        joinedAt: Date = Date(),
        userID: String? = nil,
        userEmail: String? = nil
    ) {
        self.name = name
        self.email = email
        self.phone = phone
        self.eventTitle = eventTitle
        self.joinedAt = joinedAt
        self.userID = userID
        self.userEmail = userEmail
    }
}
