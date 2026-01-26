//
//  welcomePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI

struct welcomePage: View {
    
    @State private var animateAppIcon = false
    @State private var navigateToLogIn = false
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
                .opacity(0.1)
                
                
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
                    
                    
                    //                    Spacer()
                    
                    Text("a green planner for organizing community clean-up and tree-planting events..")
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                    //                    .padding(10)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.topColour)
                    
                    //                    Spacer()
                    
                    //                    NavigationLink(destination: logInPage()){
                    //                        Text("Continue")
                    //                            .fontWeight(.semibold)
                    //                            .foregroundColor(.darker)
                    //                            .padding(.vertical, 12)
                    //                            .padding(.horizontal, 30)
                    //                            .background(Color.green.opacity(0.2))
                    //                            .cornerRadius(10)
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
                    logInPage()
                }
            }
        }
        
    }
        
        
}

#Preview {
    welcomePage()
}

