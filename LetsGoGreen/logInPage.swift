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
                        .keyboardType(.emailAddress)
                        .padding()
                       
                    
                    SecureField("Password", text: $Password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(.topColour)
                        .padding()
                    
                    NavigationLink(destination: joinAndCreatePage()){
                    Text("Log In")
                            .fontWeight(.bold)
                            .fontDesign(.serif)
                            .foregroundColor(.black)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 35)
                            .background(Color.green)
                            .opacity(0.7)
                            .cornerRadius(10)
                    }
                    
                   .padding()
                    
                   
                    Text("Don't have an account?")
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .fontDesign(.serif)
                    
                  
                
                    NavigationLink(destination: signUpPage()){
                        Text("Sign up")
                            .fontWeight(.semibold)
                            .fontDesign(.serif)
                            .foregroundColor(.green)
//                            .padding(.vertical, 12)
//                            .padding(.horizontal, 30)
//                            .background(Color.green.opacity(0.2))
//                            .cornerRadius(10)
                    }
                    
                }
                
            }
//            .padding()
        }
    }
}

#Preview {
    logInPage()
}
