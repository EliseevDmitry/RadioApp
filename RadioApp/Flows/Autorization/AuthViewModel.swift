//
//  AuthViewModel.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 11.08.2024.
//

import SwiftUI

final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var username = "Mark"
    @Published var userProfileImage: UIImage? = nil
    
    @Published var error: Error?
    
    private let authService: AuthService
    @Published var isUserRegistered = false
    // MARK: - Initializer
    init(authService: AuthService = .shared) {
        self.authService = authService
    }
    
    //    MARK: - AuthService Methods
    func signIn() async {
            do {
                try await AuthService.shared.signIn(with: email, password: password)
            } catch {
                self.error = error
            }
        }
    
    func registerUser() {
        Task {
            try await AuthService.shared.registerUser(with: email, password: password, username: username)
            isUserRegistered = true
        }
    }
    
}
