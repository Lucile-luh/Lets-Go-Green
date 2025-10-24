//
//  createEventPage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI
import SwiftData

struct Event: Codable {
    var title: String
    var date: Date
    var location: String
    var time: Date
    var description: String
}

struct createEventPage: View {
    @State private var events: [Event] = []
    @State private var eventTitle: String = ""
    @State private var eventDescription: String = ""
    @State private var eventLocation: String = ""
    @State private var eventTime: Date = Date()
    @State private var eventDate: Date = Date()
    
    @State private var navigateToList = false
    
    var body: some View {
        NavigationStack{
            ZStack {
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
                    
                        
                        if !eventTitle.isEmpty && !eventLocation.isEmpty && !eventDescription.isEmpty {
                            Button {
                                let newEvent = Event(title: eventTitle,
                                    date: eventDate,
                                    location: eventLocation,
                                    time: eventTime,
                                    description: eventDescription
                                )
                                
                                if  !events.isEmpty {
                                    events.append(newEvent)
                                }
                                
                                
                                loadEvents()
                                saveEvents()
                                navigateToList = true
                                resetFields()
                            } label: {
                                Label("Add Event", systemImage: "plus.circle.fill")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 10)
                        }
                        
                        // Hidden NavigationLink that triggers programmatically
                        NavigationLink(
                            destination:  EventListPage(event: Event(title: "1st of every month clean up", date: Date(), location: "Around mkhosana", time: Date(), description: "A monthly community clean up event.")),
                            isActive: $navigateToList
                        ) {
                        }
                    }
                
                .onAppear(perform: loadEvents)
            }
        }
        
        //
    }
    private func saveEvents() {
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: "events")
        }
    }
    
    private func loadEvents() {
        if let data = UserDefaults.standard.data(forKey: "events"),
           let decodedEvents = try? JSONDecoder().decode([Event].self, from: data) {
            events = decodedEvents
        }
    }
    
    private func resetFields() {
        eventTitle = ""
        eventDescription = ""
        eventLocation = ""
        eventTime = Date()
        eventDate = Date()
    }
}

#Preview {
    createEventPage()
}
