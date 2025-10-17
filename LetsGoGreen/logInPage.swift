//
//  logInPage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI

struct logInPage: View {
    @State private var username: String = ""
    @State private var Password: String = ""
    
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
                
                VStack {
                    Image( "appIconLTG")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(1,contentMode: .fit)
                    

                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .background(.middlecolor.opacity(0.3))
                        .foregroundStyle(.topColour)
                        
                        .cornerRadius(0.6)
                        .padding()
                       
                    
                    SecureField("Password", text: $Password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .background(.middlecolor.opacity(0.3))
                        .foregroundStyle(.topColour)
                        .padding()
                }
                
            }
//            .padding()
        }
    }
}

#Preview {
    logInPage()
}
