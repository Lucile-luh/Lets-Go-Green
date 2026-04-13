//
//  joinEventPage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI
import SwiftData
import MapKit

extension CLLocationCoordinate2D {
    // Fallback coordinate used until the event location is geocoded.
    static let cleanUpArea = CLLocationCoordinate2D(latitude: -17.93378, longitude: 25.81196)
}

struct joinEventPage: View {
    @ObservedObject var authViewModel: AuthViewModel
    @Environment(\.modelContext) private var modelContext
    @Query var participants: [Participant]
    
    let event: Event
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var showDetails: Bool = false
    @State private var mapPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: .cleanUpArea,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    ))
    @State private var eventCoordinate: CLLocationCoordinate2D = .cleanUpArea
    
    // Limits the participant list to people who joined this event.
    private var filteredParticipants: [Participant] {
        participants.filter { $0.eventTitle == event.title }
    }
    
    // Finds participant records that belong to the signed-in user.
    private var currentUserParticipants: [Participant] {
        guard let currentUserID = authViewModel.currentUserID else {
            return []
        }
        
        let currentUserEmail = authViewModel.currentUserEmail
        return filteredParticipants.filter { participant in
            participant.userID == currentUserID ||
            (participant.userEmail != nil && participant.userEmail == currentUserEmail)
        }
    }
    
    // Prevents the same signed-in user from joining an event twice.
    private var hasJoined: Bool {
        currentUserParticipants.isEmpty == false
    }
    
    var body: some View {
        NavigationStack {
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
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Displays the selected event's details.
                        Text("Join Event")
                            .font(.largeTitle)
                            .fontDesign(.serif)
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(event.title)
                                .font(.headline)
                            Text(event.info)
                                .font(.subheadline)
                            Text("Location: \(event.location)")
                                .font(.subheadline)
                            Text("Date: \(event.date.formatted(date: .abbreviated, time: .omitted)) Time: \(event.time.formatted(date: .omitted, time: .shortened))")
                                .font(.footnote)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal, 16)
                        
                        // Centers the map on the event location.
                        Map(position: $mapPosition) {
                            Annotation("Event", coordinate: eventCoordinate) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.green)
                            }
                        }
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal, 16)
                        .task {
                            await updateMapForEvent()
                        }
                        
                        
                        
                        // Lets the user join the event or share it with others.
                        HStack(spacing: 12) {
                            Button {
                                guard hasJoined == false else {
                                    return
                                }
                                let participant = Participant(
                                    name: name.isEmpty ? "Guest" : name,
                                    email: email,
                                    phone: phone,
                                    eventTitle: event.title,
                                    userID: authViewModel.currentUserID,
                                    userEmail: authViewModel.currentUserEmail
                                )
                                modelContext.insert(participant)
                                resetFields()
                            } label: {
                                Label(hasJoined ? "Joined" : "Join Now", systemImage: hasJoined ? "checkmark.circle.fill" : "person.crop.circle.badge.plus")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(hasJoined ? .gray : .green)
                            .disabled(hasJoined)
                            
                            ShareLink(item: "\(event.title) - \(event.location) on \(event.date.formatted(date: .abbreviated, time: .omitted))") {
                                Label("Invite", systemImage: "square.and.arrow.up")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .tint(.green)
                        }
                        .padding(.horizontal, 16)
                        
                        
                        DisclosureGroup("Add details", isExpanded: $showDetails) {
                            VStack(alignment: .leading, spacing: 12) {
                                TextField("Full name", text: $name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                TextField("Email (optional)", text: $email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                TextField("Phone (optional)", text: $phone)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            .padding(.top, 8)
                        }
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        
                        // Shows everyone currently registered for the event.
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Participants (\(filteredParticipants.count))")
                                .font(.headline)
                            if hasJoined {
                                Label("You are tracking this event", systemImage: "bookmark.fill")
                                    .font(.subheadline)
                                    .foregroundStyle(.green)
                            }
                            if filteredParticipants.isEmpty {
                                Text("No one has joined yet.")
                                    .foregroundStyle(.secondary)
                            } else {
                                ForEach(filteredParticipants, id: \.id) { participant in
                                    HStack {
                                        Text(participant.name)
                                            .font(.subheadline.weight(.semibold))
                                        Spacer()
                                    }
                                    .padding(10)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                BottomNavBar(authViewModel: authViewModel, currentPage: .events)
            }
        }
    }
    
    // Clears the optional participant details after joining.
    private func resetFields() {
        name = ""
        email = ""
        phone = ""
        showDetails = false
    }
    
    // Converts the event's address into map coordinates for the  map.
    private func updateMapForEvent() async {
        guard let request = MKGeocodingRequest(addressString: event.location) else {
            return
        }
        do {
            let mapItems = try await request.mapItems
            if let mapItem = mapItems.first {
                let coordinate = mapItem.location.coordinate
                await MainActor.run {
                    eventCoordinate = coordinate
                    mapPosition = .region(MKCoordinateRegion(
                        center: coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    ))
                }
            }
        } catch {
            // Keep default coordinate if geocoding fails.
        }
    }
    
}

#Preview {
    joinEventPage(authViewModel: AuthViewModel(), event: Event(title: "Park Cleanup", date: .now, location: "Chamabondo", time: .now, info: "Bring gloves and water."))
}
