//
//  AuthViewModel.swift
//  LetsGoGreen
//
//  Created by Lucile G on 20/3/2026.
//

import SwiftUI
import Supabase
internal import Combine

@MainActor

class AuthViewModel: ObservableObject {
    // Publishes the current authentication state for the UI.
    @Published var session: Session?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var statusMessage: String?
    
    // Exposes the  user's id for event participation tracking.
    var currentUserID: String? {
        session?.user.id.uuidString
    }
    
    
    var currentUserEmail: String? {
        session?.user.email?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    private func updateAuthenticationState(with session: Session?) {
        guard let session, !session.isExpired else {
            clearAuthenticationState()
            return
        }
        
        self.session = session
        self.isAuthenticated = true
        self.errorMessage = nil
    }
    
    private func clearAuthenticationState() {
        self.session = nil
        self.isAuthenticated = false
    }
    
    // Restores any existing Supabase session when the app launches.
    func getInitialSession() async {
        do {
            let current = try await supabase.auth.session
            updateAuthenticationState(with: current)
            self.statusMessage = nil
        } catch {
            if let localSession = supabase.auth.currentSession, localSession.isExpired {
                try? await supabase.auth.signOut()
            }
            clearAuthenticationState()
            print("No active session: \(error.localizedDescription)")
        }
    }
    
    // Creates a new Supabase account and updates local authentication state.
    func signUp(email: String, password: String) async {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        errorMessage = nil
        statusMessage = nil
        isLoading = true
        defer { isLoading = false }
        
        do{
            let result = try await supabase.auth.signUp(email: trimmedEmail, password: password)
            updateAuthenticationState(with: result.session)
            
            let user = result.user
            statusMessage = "Supabase created user: \(user.email ?? trimmedEmail)"
            
            if result.session == nil {
                statusMessage = "Account created. Check your email to confirm your account before signing in."
            }
            
        }catch {
            self.errorMessage = error.localizedDescription
            print("SignUp failed: \(error.localizedDescription)")
        }
    }
    
    // Signs the user in with Supabase and updates the session used by the app.
    func logIn(email: String, password: String) async {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        errorMessage = nil
        statusMessage = nil
        isLoading = true
        defer { isLoading = false }
        
        do{
            let result = try await supabase.auth.signIn(email: trimmedEmail, password: password)
            updateAuthenticationState(with: result)
            
        } catch {
            clearAuthenticationState()
            self.errorMessage = error.localizedDescription
            print("LogIn failed: \(error.localizedDescription)")
        }
        
    }
    
    // Clears the active session and returns the app to the authentication flow.
    func logOut() async {
        do {
            try await supabase.auth.signOut()
            clearAuthenticationState()
            self.errorMessage = nil
            self.statusMessage = nil
            
        } catch {
            self.errorMessage = error.localizedDescription
            print("LogOut failed: \(error.localizedDescription)")
        }
    }
    
}
