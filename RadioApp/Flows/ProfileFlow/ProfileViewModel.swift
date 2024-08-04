//
//  ProfileViewModel.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 28.07.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

final class ProfileViewModel: ObservableObject {
    // MARK: Stored Properties
    @Published var currentUser: UserModel?
    @Published var userAvatar: UIImage?
    @Published var error: Error?
    
    private let authService = AuthService.shared
    
    init() {
        fetchUser()
    }
    
    // MARK: Methods
    func fetchUser() {
      
    }
    
    func updateUserInfo() {
//        Task {
//            do {
//                try await authService.updateUserInfo(
//                    name: name,
//                    email: email,
//                    photoURL: photoURL
//                )
//            } catch {
//                print("Failed to update user information: \(error)")
//            }
//        }
    }
    
    func logOut() {
        do {
            try authService.signUserOut()
        } catch {
            self.error = error
        }
    }
    
    func clearError() {
        self.error = nil
    }
}
