//
//  Eventlist.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 22/10/2025.
//

import SwiftUI
import SwiftData

struct EventListPage: View {
    @Environment(\.modelContext) private var modelContext
    @Query var event: [Event]
    @Query var participants: [Participant]
    @EnvironmentObject var viewModel: EventViewModel

    private var sortedEvents: [Event] {
        event
            .filter { isCompleted($0) == false }
            .sorted { $0.date < $1.date }
    }

    var body: some View {
        
        NavigationStack {
            ZStack {
                // MARK: background
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
                        ForEach(sortedEvents, id: \.id) { event in
                            eventRow(for: event)
                        }
                        .onDelete(perform: deleteItems)

                        NavigationLink(destination: createEventPage()) {
                            Image(systemName: "rectangle.stack.fill.badge.plus")
                                .imageScale(.large)
                                .padding(.vertical, 8)
                        }
                        .foregroundStyle(.darker)
                    }
                    .scrollContentBackground(.hidden)
                    .task {
                        purgeCompletedEvents()
                    }
                    
                }
                .safeAreaInset(edge: .bottom) {
                    BottomNavBar()
                }
            }
        }
    }

    @ViewBuilder
    private func eventRow(for event: Event) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(event.title)
                    .font(.headline)
                Spacer()
                Text(eventStatusText(for: event))
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(eventStatusColor(for: event).opacity(0.15))
                    .clipShape(Capsule())
            }

            Text(event.info)
                .font(.subheadline)
            Text("Location: \(event.location)")
                .font(.subheadline)
            Text("Date: \(event.date, formatter: DateFormatter.shortDate) Time: \(event.time, formatter: DateFormatter.shortTime)")
                .font(.footnote)

            HStack {
                Label(event.location, systemImage: "mappin.and.ellipse")
                    .font(.footnote)
                    .foregroundColor(.darker)
                    .fontWeight(.heavy)
                Spacer()
                Label("\(participantCount(for: event)) joined", systemImage: "person.2.fill")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            NavigationLink(destination: joinEventPage(event: event)) {
                Label("View Event", systemImage: "person.crop.circle.fill.badge.plus")
                    .padding(.vertical, 8)
            }
            .foregroundStyle(.darker)
        }
        .padding(.vertical, 4)
    }

    private func participantCount(for event: Event) -> Int {
        participants.filter { $0.eventTitle == event.title }.count
    }

    private func eventStatusText(for event: Event) -> String {
        if isCompleted(event) {
            return "Completed"
        }
        if Calendar.current.isDate(event.scheduledAt, equalTo: Date(), toGranularity: .day) {
            return "Happening"
        }
        return "Upcoming"
    }

    private func eventStatusColor(for event: Event) -> Color {
        if isCompleted(event) {
            return .gray
        }
        if Calendar.current.isDate(event.scheduledAt, equalTo: Date(), toGranularity: .day) {
            return .orange
        }
        return .green
    }

    private func isCompleted(_ event: Event) -> Bool {
        event.scheduledAt < Date()
    }

    private func purgeCompletedEvents() {
        let completedEvents = event.filter(isCompleted)

        guard completedEvents.isEmpty == false else {
            return
        }

        for completedEvent in completedEvents {
            let relatedParticipants = participants.filter { $0.eventTitle == completedEvent.title }
            for participant in relatedParticipants {
                modelContext.delete(participant)
            }
            modelContext.delete(completedEvent)
        }

        saveContext()
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = sortedEvents[index]
            modelContext.delete(item)
        }
        saveContext()
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context after deletion: \(error)")
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
