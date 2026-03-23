//
//  ContentView.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI



struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    var body: some View {
        
        
        Group{
           
            if authViewModel.isAuthenticated {
                HomePage(authViewModel: authViewModel)
            }else{
                logInPage(authViewModel: authViewModel)
            }
        }
        .task {
            await authViewModel.getInitialSession()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(EventViewModel())
}
