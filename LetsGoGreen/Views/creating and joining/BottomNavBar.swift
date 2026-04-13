//
//  BottomNavBar.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 3/2/2026.
//

import SwiftUI

enum BottomNavDestination {
    case home
    case events
    case create
    case profile
}

struct BottomNavBar: View {
    @ObservedObject var authViewModel: AuthViewModel
    let currentPage: BottomNavDestination
    
    var body: some View {
        // Provides quick navigation between the app's main screens.
        HStack(spacing: 24) {
            navItem(
                for: .home,
                destination: HomePage(authViewModel: authViewModel),
                label: "Home",
                systemImage: "house"
            )
            navItem(
                for: .events,
                destination: EventListPage(authViewModel: authViewModel),
                label: "Events",
                systemImage: "list.bullet"
            )
            navItem(
                for: .create,
                destination: createEventPage(authViewModel: authViewModel),
                label: "Create",
                systemImage: "plus.circle"
            )
            navItem(
                for: .profile,
                destination: ProfilePage(authViewModel: authViewModel),
                label: "Profile",
                systemImage: "person.circle"
            )
        }
        .font(.caption)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.white)
        .clipShape(Capsule())
        .padding(.bottom, 8)
        .shadow(radius: 4)
    }
    
    @ViewBuilder
    private func navItem<Destination: View>(
        for page: BottomNavDestination,
        destination: Destination,
        label: String,
        systemImage: String
    ) -> some View {
        if currentPage == page {
            NavItem(label: label, systemImage: systemImage, isSelected: true)
        } else {
            NavigationLink(destination: destination) {
                NavItem(label: label, systemImage: systemImage, isSelected: false)
            }
        }
    }
}

private struct NavItem: View {
    let label: String
    let systemImage: String
    let isSelected: Bool
    
    var body: some View {
        // Formats a single navigation item with an icon and label.
        VStack(spacing: 4) {
            Image(systemName: systemImage)
                .imageScale(.medium)
            Text(label)
        }
        .foregroundStyle(isSelected ? .green : .primary)
    }
}

#Preview {
    NavigationStack {
        BottomNavBar(authViewModel: AuthViewModel(), currentPage: .home)
    }
}
