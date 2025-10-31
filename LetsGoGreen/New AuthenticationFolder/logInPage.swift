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
    @State private var alertTitle1 = ""
    @State private var alertMessage1 = ""
    @State private var showAlert1 = false
    @State private var navigateToHomePage = false
    
    
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
    
                    Button(action: {
                        attempLogin()
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.topColour)
                                .opacity(0.4)
                                .frame(width: 180, height: 50)
                                .shadow(radius: 5)
                            
                            Text("Next")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .fontDesign(.serif)
                        }
                    }
                    .padding()

                        Text("Don't have an account?")
                            .foregroundColor(.black)
                            .fontWeight(.heavy)
                            .fontDesign(.serif)
                    
                    NavigationLink(destination: SignUpPage()) {
                        Text("Sign Up")
                            .foregroundColor(.topColour)
                            .fontWeight(.bold)
                            .fontDesign(.serif)
                    }
                }
               
            }
            .navigationDestination(isPresented: $navigateToHomePage){
                HomePage()
            }
            .alert(alertTitle1, isPresented: $showAlert1){
                Button("Ok"){
                    if alertTitle1.hasPrefix("Welcome"){
                        navigateToHomePage = true
                    }else {
                        print("wrong")
                    }
                }
            }message: {
                Text(alertMessage1)
            }
        }
    }

    func attempLogin() {
        if Password.count < 8 {
            alertTitle1 = "Weak Password"
            alertMessage1 = "Please choose a stronger password with at least 8 characters to protect your Let's Go Green account."
            showAlert1 = true
            return
        }
        let formattedName = username.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
        alertTitle1 = "Welcome back \(formattedName)"
        alertMessage1 = "🌿 Lets plan more sustainable adventures together."
        showAlert1 = true
    }

}

#Preview {
    logInPage()
}
