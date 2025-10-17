//
//  welcomePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI

struct welcomePage: View {
    
    @State private var animateAppIcon = false
    var body: some View {
        
        NavigationStack {
            
                
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.95, green: 1.0, blue: 0.95), // Light mint green
                        Color(red: 0.3, green: 0.85, blue: 0.3)   // Leafy green
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                
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
                    
                    NavigationLink(destination: logInPage()){
                        Text("Continue")
                            .fontWeight(.semibold)
                            .foregroundColor(.topColour)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 30)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(10)
                        
                        
                    }
                    
                }
            }
                
            }
            .onAppear{
                animateAppIcon = true
            }
            
        }
//        .padding()
        
        
}

#Preview {
    welcomePage()
}
