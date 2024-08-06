//
//  ProfileViewModel.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 28.07.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase


final class ProfileViewModel: ObservableObject {
    // MARK: - Stored Properties
    @Published var currentUser: UserModel?
    @Published var userAvatar: UIImage?
    @Published var error: Error?
    
    private let authService = AuthService.shared
    
    // MARK: - Initializer
    init() {
        fetchUser()
    }
    
    // MARK: - Methods
    func fetchUser() {
        currentUser = authService.getCurrentUserModel()
    }
    
    func updateUserProfile(_ name: String?, _ email: String?, _ avatar: UIImage?) {
        Task {
            do {
                var photoURL: URL? = nil
                
                if let avatar = avatar {
                    photoURL = try await authService.uploadAvatar(image: avatar, userId: currentUser?.id ?? "")
                }
                
                if let email = email {
                    try await authService.updateEmail(email)
                }
                
                try await authService.updateUserProfile(displayName: name, photoURL: photoURL)
                
                fetchUser()
            } catch {
                self.error = error
            }
        }
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
