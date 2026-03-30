//
//  welcomePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI

struct welcomePage: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var animateAppIcon = false
    @State private var navigateToLogIn = false
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
                
                // Introduces the app and routes the user into the login flow.
                VStack(spacing: 20) {
                    Image("appIconLTG")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                    Text("Welcome to ")
                        .fontDesign(.rounded)
                        .fontWeight(.heavy)
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.topColour)
                    
                    
                    Text("a green planner for organizing community clean-up and tree-planting events..")
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                    
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.topColour)
                    
                    // Navigates from the welcome screen to the login screen.
                    Button(action: {
                        navigateToLogIn = true
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.topColour)
                                .opacity(0.4)
                                .frame(width: 180, height: 50)
                                .shadow(radius: 5)
                            
                            Text("Continue")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .fontDesign(.serif)
                        }
                        
                    }
                    .padding(.top, 30)
                    Spacer()
                }
                .offset(y: 100)
                .navigationDestination(isPresented: $navigateToLogIn) {
                    logInPage(authViewModel: authViewModel)
                }
            }
        }
    }
}

#Preview {
    welcomePage()
}
