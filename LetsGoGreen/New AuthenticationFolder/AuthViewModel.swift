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
    
    @Published var session: Session?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var statusMessage: String?

    var currentUserID: String? {
        session?.user.id.uuidString
    }

    var currentUserEmail: String? {
        session?.user.email?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    func getInitialSession() async {
        do{
            let current = try await supabase.auth.session
            self.session = current
            self.isAuthenticated = true
            self.errorMessage = nil
            self.statusMessage = nil
            
        }catch {
            self.session = nil
            self.isAuthenticated = false
            print("No active session: \(error.localizedDescription)")
        }
    }
    
    func signUp(email: String, password: String) async {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        errorMessage = nil
        statusMessage = nil
        isLoading = true
        defer { isLoading = false }
        
        do{
            let result = try await supabase.auth.signUp(email: trimmedEmail, password: password)
            self.session = result.session
            self.isAuthenticated = self.session != nil
            
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
    
    func logIn(email: String, password: String) async {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        errorMessage = nil
        statusMessage = nil
        isLoading = true
        defer { isLoading = false }
        
        do{
            let result = try await supabase.auth.signIn(email: trimmedEmail, password: password)
            self.session = result
            self.isAuthenticated = self.session != nil
            self.errorMessage = nil
            
        } catch {
            self.session = nil
            self.isAuthenticated = false
            self.errorMessage = error.localizedDescription
            print("LogIn failed: \(error.localizedDescription)")
        }
        
    }
    
    func logOut() async {
        do {
             try await supabase.auth.signOut()
            self.session = nil
            self.isAuthenticated = false
            self.errorMessage = nil
            self.statusMessage = nil
            
        } catch {
            self.errorMessage = error.localizedDescription
            print("LogOut failed: \(error.localizedDescription)")
        }
    }
    
}
