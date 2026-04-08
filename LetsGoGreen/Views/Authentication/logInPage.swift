//
//  logInPage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI

struct logInPage: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                
                VStack {
                    // Shows the app icon.
                    Image( "appIconLTG")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .aspectRatio(1,contentMode: .fit)
                    
                    // Collects the user's login credentials.
                    TextField("email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .foregroundStyle(.topColour)
                        .padding()
                        .keyboardType(.emailAddress)
                    
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(.topColour)
                        .padding()
                    
                    // Starts the  sign-in request.
                    Button("Sign In"){
                        Task{
                            await authViewModel.logIn(email: email, password: password)
                        }
                    }
                    .disabled(authViewModel.isLoading || email.isEmpty || password.isEmpty)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.title)
                    .fontDesign(.serif)
                    .padding(10)
                    
                    if authViewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    }
                    
                    // Displays the latest authentication error returned by Supabase.
                    if let errorMessage = authViewModel.errorMessage {
                        Text(errorMessage)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                    }
                    
                    // Links new users to the account creation page.
                    Text("Don't have an account?")
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                        .fontDesign(.serif)
                    
                    NavigationLink(destination: SignUpPage(authViewModel: authViewModel)) {
                        Text("Sign Up")
                            .foregroundColor(.topColour)
                            .fontWeight(.bold)
                            .fontDesign(.serif)
                    }
                }
                
            }
            
        }
    }
}

//    func attempLogin() {
//        if password.count < 8 {
//            alertTitle1 = "Weak Password"
//            alertMessage1 = "Please choose a stronger password with at least 8 characters to protect your Let's Go Green account."
//            showAlert1 = true
//            return
//        }
//        let formattedName = email.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
//        alertTitle1 = "Welcome back"
//        alertMessage1 = "🌿 Lets plan more sustainable adventures together."
//        showAlert1 = true
//    }

//    }

#Preview {
    logInPage(authViewModel: AuthViewModel())
}
