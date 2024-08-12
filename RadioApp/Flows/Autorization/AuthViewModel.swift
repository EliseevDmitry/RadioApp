//
//  AuthViewModel.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 11.08.2024.
//

import SwiftUI

final class AuthViewModel: ObservableObject {
    var email = ""
    var password = ""
    @Published var username = "Mark"
   
    @Published var isAuthenticated: Bool
    @Published var error: Error?
    
    private let authService: AuthService
    @Published var isUserRegistered = false
    // MARK: - Initializer
    init(authService: AuthService = .shared) {
        self.authService = authService
        isAuthenticated = authService.isAuthenticated()
    }
    
    func cancelErrorAlert() { error = nil }
    
    //    MARK: - AuthService Methods
    func signIn() async {
            do {
                try await authService.signIn(with: email, password: password)
                isAuthenticated = authService.isAuthenticated()
                print("isAuthenticated set to \(isAuthenticated)")
            } catch {
                self.error = error
            }
        }
    
    func registerUser() {
        Task {
            try await authService.registerUser(with: email, password: password, username: username)
            isUserRegistered = true
        }
    }
    
}
