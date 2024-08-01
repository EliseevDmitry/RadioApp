//
//  SignInViewModel.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 01.08.2024.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showPassword = false
    
    func signIn() {
        Task {
            try await AuthService.shared.signIn(with: email, password: password)
        }
    }
}
