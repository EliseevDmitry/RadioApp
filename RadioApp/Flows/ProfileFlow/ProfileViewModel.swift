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

@MainActor
final class ProfileViewModel: ObservableObject {
    // MARK: - Stored Properties
    @Published var currentUser: UserModel?
    @Published var error: Error?
    
    private let authService = AuthService.shared
    private let notificationService = NotificationsService.shared
    
    // MARK: - Initializer
    init() {
        fetchUser()
    }
    
    // MARK: - Methods
    func fetchUser() {
        Task {
            currentUser = authService.getCurrentUserModel()
        }
    }
    
    func getProfileImage(path: String) {
        guard currentUser != nil else { return }
        Task {
          try await authService.getUrlForImage(path: path)
        }
    }
    
    func saveProfileImage(_ image: UIImage) {
        guard let currentUser else { return }
        
        Task {
            let (_, _) = try await authService.saveImage(image: image, userID: currentUser.id) //let (path, name)
        }
    }
    
    func updateUserProfile(_ name: String?, _ email: String?, _ avatar: UIImage?) {
        Task {
            do {
                let photoURL: URL? = nil //var
                
//                if let avatar = avatar {
//                    photoURL = try await authService.uploadAvatar(image: avatar, userId: currentUser?.id ?? "")
//                }
                
                if let email = email {
                    try await authService.updateEmail(email)
                }
                
                try await authService.updateUserProfile(displayName: name, photoURL: photoURL)
                
                await MainActor.run {
                    fetchUser()
                }
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
    
    func logOut() {
        do {
            try authService.signUserOut()
        } catch {
            Task {
                self.error = error
            }
        }
    }
    
    func clearError() {
        Task {
            self.error = nil
        }
    }
    
//    MARK: - Notifications
   
    func notificationAction() {
        notificationService.sendTestNotification()
    }
}
