//
//  Eventlist.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 22/10/2025.
//

import SwiftUI
import SwiftData

struct EventListPage: View {
    @Query var event: [Event]
    
    @State private var events: [Event] = []
    
    var body: some View {
        
        NavigationStack {
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
                        ForEach(events, id: \.id) { event in
                            VStack(alignment: .leading) {
                                Text(event.title)
                                    .font(.headline)
                                Text(event.info)
                                    .font(.subheadline)
                                Text("Location: \(event.location)")
                                    .font(.subheadline)
                                Text("Date: \(event.date, formatter: DateFormatter.shortDate) Time: \(event.time, formatter: DateFormatter.shortTime)")
                                    .font(.footnote)
                                    
                            }
                            .padding()
                        }
                        NavigationLink(destination: createEventPage()) {
                            Image(systemName: "rectangle.stack.fill.badge.plus")
                                .imageScale(.large)
                                .padding(.vertical, 8)
                        }
                        .foregroundStyle(.darker)
                        
                        
                    }
                    .scrollContentBackground(.hidden)
                    .onAppear {
                        
                    }
                    
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
    EventListPage()
}
