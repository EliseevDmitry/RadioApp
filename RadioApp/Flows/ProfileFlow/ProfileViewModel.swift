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
import _PhotosUI_SwiftUI


final class ProfileViewModel: ObservableObject {
    // MARK: - Stored Properties
    @Published var currentUser: UserModel?
    @Published var error: Error?
    
    private let authService = AuthService.shared
    
    // MARK: - Initializer
    init() {
        fetchUser()
    }
    
    // MARK: - Methods
    func fetchUser() {
        Task { @MainActor in
            currentUser = authService.getCurrentUserModel()
        }
    }
    
    @available(iOS 16.0, *)
    func saveProfileImage(item: PhotosPickerItem) {
        guard let currentUser else { return }
        
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, name) = try await authService.saveImage(data: data, userID: currentUser.id)
        }
    }
    
    func updateUserProfile(_ name: String?, _ email: String?, _ avatar: UIImage?) {
        Task {
            do {
                var photoURL: URL? = nil
                
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
            Task { @MainActor in
                self.error = error
            }
        }
    }
    
    func clearError() {
        Task { @MainActor in
            self.error = nil
        }
    }
}
