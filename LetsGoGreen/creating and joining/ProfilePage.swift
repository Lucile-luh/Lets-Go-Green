//
//  ProfilePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 3/2/2026.
//

import SwiftUI
import SwiftData

struct ProfilePage: View {
    @Query private var events: [Event]
    @Query private var participants: [Participant]

    private var joinedEventTitles: Set<String> {
        Set(participants.map(\.eventTitle))
    }

    private var joinedEvents: [Event] {
        events
            .filter { joinedEventTitles.contains($0.title) }
            .sorted { $0.date < $1.date }
    }

    private var upcomingJoinedEvents: [Event] {
        joinedEvents.filter { $0.date >= Calendar.current.startOfDay(for: Date()) }
    }

    private var completedJoinedEvents: [Event] {
        joinedEvents.filter { $0.date < Calendar.current.startOfDay(for: Date()) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("treePlanting").resizable().ignoresSafeArea()
                    .opacity(0.8)
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.95, green: 1.0, blue: 0.95),
                        Color(red: 0.3, green: 0.85, blue: 0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .opacity(0.1)

                VStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 140))
                        .foregroundStyle(.universal)
                    Text("Profile")
                        .font(.largeTitle)
                    Text("Track your event activity here.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    VStack(spacing: 12) {
                        statCard(title: "Events Joined", value: "\(joinedEvents.count)")
                        statCard(title: "Upcoming", value: "\(upcomingJoinedEvents.count)")
                        statCard(title: "Completed", value: "\(completedJoinedEvents.count)")
                    }
                    .padding(.horizontal, 20)

                    if joinedEvents.isEmpty {
                        Text("You have not joined any events yet.")
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)
                    } else {
                        List {
                            Section("My Events") {
                                ForEach(joinedEvents, id: \.id) { event in
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(event.title)
                                            .font(.headline)
                                        Text(event.location)
                                            .font(.subheadline)
                                        Text(event.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.footnote)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                BottomNavBar()
            }
        }
    }

    private func statCard(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.title3.weight(.bold))
                .foregroundStyle(.green)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    ProfilePage()
}
