//
//  signUpPage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI


struct signUpPage: View {
    @State private var username: String = ""
    @State private var Password: String = ""
    @State private var email: String = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var navigateToHomePage = false
    
    
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
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(.topColour)
                        .cornerRadius(0.6)
                        .padding()
                    
                    SecureField("Password", text: $Password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(.topColour)
                        .padding()
                    
                    //                    if !username.isEmpty && !email.isEmpty && !Password.isEmpty {
                    //                        NavigationLink(destination: HomePage()){
                    //                            Text("Sign up")
                    //                                .fontWeight(.semibold)
                    //                                .fontDesign(.serif)
                    //                                .foregroundColor(.darker)
                    //                                .padding(.vertical, 12)
                    //                                .padding(.horizontal, 30)
                    //                                .background(Color.green.opacity(0.7))
                    //                                .cornerRadius(20)
                    //
                    Button(action: {
                        attemptSignUp()
                        
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.topColour)
                                .frame(width: 180, height: 50)
                                .shadow(radius: 5)
                            
                            Text("Next")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .fontDesign(.serif)
                        }
                        
                    }
                    .padding(.top, 30)
                    Spacer()
                }
                offset(y: 100)
            }
            
            .navigationDestination(isPresented: $navigateToHomePage){
                HomePage()
            }
            .alert(alertTitle, isPresented: $showAlert){
                Button("Ok"){
                    if alertTitle.starts(with: "Success"){
                        navigateToHomePage = true
                    }
                }
            }message: {
                Text(alertMessage)
            }
        }
    }
    func attemptSignUp() {
        if Password.count < 8 {
            alertTitle = "Weak Password"
            alertMessage = "Please choose a stronger password with at least 8 characters to protect your Let's Go Green account."
            showAlert = true
            return
        }

        alertTitle = "Success"
        alertMessage = "Welcome to Let's Go Green! 🌿 You're all set to join cleanup drives and tree planting events."
        showAlert = true
    }

}

#Preview {
    signUpPage()
}
