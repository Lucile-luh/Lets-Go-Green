//
//  BottomNavBar.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 3/2/2026.
//

import SwiftUI

struct BottomNavBar: View {
    var body: some View {
        HStack(spacing: 24) {
            NavigationLink(destination: HomePage()) {
                NavItem(label: "Home", systemImage: "house")
            }

            NavigationLink(destination: EventListPage()) {
                NavItem(label: "Events", systemImage: "list.bullet")
            }

            NavigationLink(destination: createEventPage()) {
                NavItem(label: "Create", systemImage: "plus.circle")
            }

            NavigationLink(destination: EventListPage()) {
                NavItem(label: "Join", systemImage: "person.crop.circle.badge.plus")
            }

            NavigationLink(destination: ProfilePage()) {
                NavItem(label: "Profile", systemImage: "person.circle")
            }
        }
        .font(.caption)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.white)
        .clipShape(Capsule())
        .padding(.bottom, 8)
        .shadow(radius: 4)
    }
}

private struct NavItem: View {
    let label: String
    let systemImage: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: systemImage)
                .imageScale(.medium)
            Text(label)
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    NavigationStack {
        BottomNavBar()
    }
}
