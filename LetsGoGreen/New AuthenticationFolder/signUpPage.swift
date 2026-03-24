//
//  SignUpPage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI


struct SignUpPage: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var password: String = ""
    @State private var email: String = ""
    
    
    var body: some View {
        NavigationStack{
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
                .opacity(0.4)
                
                VStack {
                    Image( "appIconLTG")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .aspectRatio(1,contentMode: .fit)
                    Spacer()
                    
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .foregroundStyle(.topColour)
                        .cornerRadius(0.6)
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(.topColour)
                        .padding()
                        Spacer()
                  
                    Button("Sign Up") {
                        Task {
                            await authViewModel.signUp(email: email, password: password)
                        }
                    }
                    .disabled(authViewModel.isLoading || email.isEmpty || password.isEmpty)
                    .buttonStyle(PlainButtonStyle())
                    .foregroundStyle(.white)
                    .font(Font.title.bold())
                    .fontDesign(.serif)
                    .padding(.top, 30)
                    
                    if authViewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    }
                    
                    if let statusMessage = authViewModel.statusMessage {
                        Text(statusMessage)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                    }
                    
                    if let errorMessage = authViewModel.errorMessage {
                        Text(errorMessage)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                    }

                    Text("Already have an account?")
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                        .fontDesign(.serif)

                    NavigationLink(destination: logInPage(authViewModel: authViewModel)) {
                        Text("Log In")
                            .foregroundColor(.topColour)
                            .fontWeight(.bold)
                            .fontDesign(.serif)
                    }
                    
                    Spacer()
                }
              
            }
        }
    }
//    func attemptSignUp() {
//        if Password.count < 8 {
//            alertTitle = "Weak Password"
//            alertMessage = "Please choose a stronger password with at least 8 characters to protect your Let's Go Green account."
//            showAlert = true
//            return
//        }
//
//        alertTitle = "Success"
//        alertMessage = "Welcome to Let's Go Green! 🌿 You're all set to join cleanup drives and tree planting events."
//        showAlert = true
//    }

}

#Preview {
    SignUpPage(authViewModel: AuthViewModel())
}
