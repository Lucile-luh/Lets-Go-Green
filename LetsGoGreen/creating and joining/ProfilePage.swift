//
//  ProfilePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 3/2/2026.
//

import SwiftUI

struct ProfilePage: View {
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
                        .font(.system(size: 250))
                        .foregroundStyle(.universal)
                    Text("Profile")
                        .font(.largeTitle)
                    Text("")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .safeAreaInset(edge: .bottom) {
                BottomNavBar()
            }
        }
    }
}

#Preview {
    ProfilePage()
}
