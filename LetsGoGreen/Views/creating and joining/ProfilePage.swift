//
//  ProfilePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 3/2/2026.
//

import SwiftUI
import SwiftData

struct ProfilePage: View {
    // Stores authentication state and loads events and participants from SwiftData.
    @ObservedObject private var authViewModel: AuthViewModel
    @Query private var events: [Event]
    @Query private var participants: [Participant]
    
    
    init(authViewModel: AuthViewModel) {
        _authViewModel = ObservedObject(wrappedValue: authViewModel)
    }
    // Filters participants to only those linked to the currently signed-in user.
    private var currentUserParticipants: [Participant] {
        guard let currentUserID = authViewModel.currentUserID else {
            return []
        }
        let currentUserEmail = authViewModel.currentUserEmail
        return participants.filter { participant in
            participant.userID == currentUserID ||
            (participant.userEmail != nil && participant.userEmail == currentUserEmail)
        }
    }
    // Collects the titles of events the current user has joined.
    private var joinedEventTitles: Set<String> {
        Set(currentUserParticipants.map(\.eventTitle))
    }
    
    // Matches joined event titles to full event records and sorts them by date.
    private var joinedEvents: [Event] {
        events
            .filter { joinedEventTitles.contains($0.title) }
            .sorted { $0.date < $1.date }
    }
    
    // Separates joined events into upcoming and completed groups.
    private var upcomingJoinedEvents: [Event] {
        joinedEvents.filter { $0.date >= Calendar.current.startOfDay(for: Date()) }
    }
    
    private var completedJoinedEvents: [Event] {
        joinedEvents.filter { $0.date < Calendar.current.startOfDay(for: Date()) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background image and gradient styling.
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
                // Profile header and event activity summary cards.
                VStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 140))
                        .foregroundStyle(.universal)
                    Text("Profile")
                        .font(.largeTitle)
                    Text("Track your event activity here.")
                        .font(.title)
                        .foregroundStyle(.darker)
                    
                    VStack(spacing: 12) {
                        statCard(title: "Events Joined", value: "\(joinedEvents.count)")
                        statCard(title: "Upcoming", value: "\(upcomingJoinedEvents.count)")
                        statCard(title: "Completed", value: "\(completedJoinedEvents.count)")
                    }
                    .padding(.horizontal, 20)
                    // an empty state or a list of events the user has joined.
                    if joinedEvents.isEmpty {
                        Text("You have not joined any events yet.")
                            .foregroundStyle(.darker)
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
                    // Signs the user out and returns to the authentication flow.
                    Button("Sign Out") {
                        Task {
                            await authViewModel.logOut()
                        }
                    }
                    .foregroundStyle(.green)
                    .fontWeight(.bold)
                    .font(.title)
                    .fontDesign(.serif)
                    .padding(10)
                    
                }
                
            }
            .safeAreaInset(edge: .bottom) {
                BottomNavBar(authViewModel: authViewModel, currentPage: .profile)
            }
        }
    }
    // Reusable card view for displaying profile statistics.
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

//#Preview {
//    ProfilePage()
//}
