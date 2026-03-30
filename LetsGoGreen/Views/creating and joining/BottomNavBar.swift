//
//  BottomNavBar.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 3/2/2026.
//

import SwiftUI

struct BottomNavBar: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        // Provides quick navigation between the app's main screens.
        HStack(spacing: 24) {
            NavigationLink(destination: HomePage(authViewModel: authViewModel)) {
                NavItem(label: "Home", systemImage: "house")
            }
            
            NavigationLink(destination: EventListPage(authViewModel: authViewModel)) {
                NavItem(label: "Events", systemImage: "list.bullet")
            }
            
            NavigationLink(destination: createEventPage(authViewModel: authViewModel)) {
                NavItem(label: "Create", systemImage: "plus.circle")
            }
            
            NavigationLink(destination: EventListPage(authViewModel: authViewModel)) {
                NavItem(label: "Join", systemImage: "person.crop.circle.badge.plus")
            }
            
            NavigationLink(destination: ProfilePage(authViewModel: authViewModel)) {
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
        // Formats a single navigation item with an icon and label.
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
        BottomNavBar(authViewModel: AuthViewModel())
    }
}
