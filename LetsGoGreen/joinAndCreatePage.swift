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
            
            
            VStack {
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
                    .opacity(0.2)
                }
            }
           
        }
    }
}

#Preview {
    joinAndCreatePage()
}
