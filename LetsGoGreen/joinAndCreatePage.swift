//
//  joinAndCreatePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI

struct joinAndCreatePage: View {
    var body: some View {
        NavigationStack{
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
                
            Image(systemName: "figure.hiking")
                    .foregroundStyle(.topColour)
                    .font(.system(size: 80, weight: .bold, design: .default))
                    .offset(x: 150, y: -270)
                    .padding()
                  
                
                VStack(spacing: 30) {
                    NavigationLink(destination: joinEventPage()){
                        Text("Join Event")
                            .font(.title)
                            .fontWeight(.semibold)
                            .fontDesign(.serif)
                            .foregroundColor(.darker)
                            .padding(.vertical, 22)
                            .padding(.horizontal, 40)
                            .background(Color.green.opacity(0.3))
                            .cornerRadius(20)
                    }
                    .padding()
                    
                        NavigationLink(destination: createEventPage()){
                            Text("Create Event")
                                .font(.title)
                                .fontWeight(.semibold)
                                .fontDesign(.serif)
                                .foregroundColor(.darker)
                                .padding(.vertical, 22)
                                .padding(.horizontal, 40)
                                .background(Color.green.opacity(0.3))
                                .cornerRadius(20)
                        }
                    
                    Image(systemName: "apple.meditate")
                        .foregroundStyle(.topColour)
                        .font(.system(size: 80, weight: .bold, design: .default))
                        .offset(x: -140, y: 230)
                        .padding()
                      
                        
                    
                }
            }
        }
    }
}

#Preview {
    joinAndCreatePage()
}
