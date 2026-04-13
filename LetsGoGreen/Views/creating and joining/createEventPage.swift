//
//  createEventPage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI
import SwiftData
import Foundation


struct createEventPage: View {
    @ObservedObject var authViewModel: AuthViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    // Stores form input while the user creates a new event.
    @State private var eventTitle: String = ""
    @State private var eventDescription: String = ""
    @State private var eventLocation: String = ""
    @State private var eventTime: Date = Date()
    @State private var eventDate: Date = Date()
    
    var body: some View {
        ZStack {
            // Background image and gradient styling.
            Image("treePlanting").resizable().ignoresSafeArea()
                .opacity(0.8)
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 1.0, blue: 0.95), // Light mint green
                    Color(red: 0.3, green: 0.85, blue: 0.3)   // Leafy green
                ]),
                
                startPoint: .topLeading,
                endPoint: .bottomTrailing
                
            )
            .ignoresSafeArea()
            .opacity(0.1)
            VStack {
                // Collects the event details before saving them to SwiftData.
                TextField("Enter event title", text: $eventTitle)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter event location", text: $eventLocation)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter event description", text: $eventDescription)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                DatePicker("Event date", selection: $eventDate, displayedComponents: .date)
                    .padding()
                
                DatePicker("Event time", selection: $eventTime, displayedComponents: .hourAndMinute)
                    .padding()
                
                //  enables event creation when the required fields are filled in.
                if !eventTitle.isEmpty && !eventLocation.isEmpty && !eventDescription.isEmpty {
                    Button {
                        let newEvent = Event(
                            title: eventTitle,
                            date: eventDate,
                            location: eventLocation,
                            time: eventTime,
                            info: eventDescription
                        )
                        context.insert(newEvent)
                        saveEventAndReturn()
                    } label: {
                        Label("Add Event", systemImage: "plus.circle.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            BottomNavBar(authViewModel: authViewModel, currentPage: .create)
        }
    }
    
    // Clears the form after a successful save.
    private func resetFields() {
        eventTitle = ""
        eventDescription = ""
        eventLocation = ""
        eventTime = Date()
        eventDate = Date()
    }
    
    // Persists the new event and returns to the previous screen.
    private func saveEventAndReturn() {
        do {
            try context.save()
            resetFields()
            dismiss()
        } catch {
            print("Failed to save new event: \(error)")
        }
    }
}

#Preview {
    createEventPage(authViewModel: AuthViewModel())
}
