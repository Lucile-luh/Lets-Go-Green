//
//  signUpPage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI
import Firebase

struct signUpPage: View {
    @State private var username: String = ""
    @State private var Password: String = ""
    @State private var email: String = ""
    
    init(){
        FirebaseApp.configure()
    }
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
                
                VStack {
                    Image( "appIconLTG")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .aspectRatio(1,contentMode: .fit)
                    
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(.topColour)
                        .cornerRadius(0.6)
                        .padding()
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(.topColour)
                        .cornerRadius(0.6)
                        .padding()
                    
                    SecureField("Password", text: $Password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(.topColour)
                        .padding()
                    
                    NavigationLink(destination: joinAndCreatePage()){
                        Text("Sign up")
                            .fontWeight(.semibold)
                            .fontDesign(.serif)
                            .foregroundColor(.darker)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 30)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(20)
                        
                        
                    }
                }
//                private func handleSignUp() {
//                    
//                }
            }
        }
    }
}

#Preview {
    signUpPage()
}
