//
//  AuthViewModel.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 11.08.2024.
//

import Foundation

final class AuthViewModel: ObservableObject {
    
    
    func signIn() async {
            do {
                try await AuthService.shared.signIn(with: email, password: password)
            } catch {
//                self.error = error
            }
        }
}
