//
//  Eventlist.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 22/10/2025.
//

import SwiftUI
    struct EventListPage: View {
        @State private var events: [Event] = []
    var event: Event

        var body: some View {
            
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
                    .opacity(0.2)
                VStack {
                    
                    Text("Event List")
                        .font(.largeTitle)
                        .padding()
                    
                    
                    List {
                        if events.isEmpty {
                            VStack(alignment: .leading) {
                                Text(event.title)
                                    .font(.headline)
                                Text(event.description)
                                    .font(.subheadline)
                                Text("Location: \(event.location)")
                                    .font(.subheadline)
                                Text("Date: \(event.date, formatter: DateFormatter.shortDate) Time: \(event.time, formatter: DateFormatter.shortTime)")
                                    .font(.footnote)
                            }
                            .padding()
                        } else {
                            ForEach(events, id: \.description) { event in
                                VStack(alignment: .leading) {
                                    Text(event.title)
                                        .font(.headline)
                                    Text(event.description)
                                        .font(.subheadline)
                                    Text("Location: \(event.location)")
                                        .font(.subheadline)
                                    Text("Date: \(event.date, formatter: DateFormatter.shortDate) Time: \(event.time, formatter: DateFormatter.shortTime)")
                                        .font(.footnote)
                                }
                                .padding()
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .onAppear {

                    }
                }
            }
        }

    }

        extension DateFormatter {
            static var shortDate: DateFormatter {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.timeStyle = .none
                return formatter
            }
            
            static var shortTime: DateFormatter {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                return formatter
            }
        
    }


#Preview {
    EventListPage(event: Event(title: "1st of every month clean up", date: Date(), location: "Around mkhosana", time: Date(), description: "A monthly community clean up event."))
}















//                        loadEvents()

//        private func loadEvents() {
//
//            if let savedEvents = UserDefaults.standard.data(forKey: "events") {
//                let decoder = JSONDecoder()
//                if let loadedEvents = try? decoder.decode([Event].self, from: savedEvents) {
//                    events = loadedEvents
//                }
//            }
//        }
