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
import FirebaseStorage

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
                    photoURL = try await uploadAvatar(image: avatar, userId: currentUser?.id ?? "")
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
    
    private func uploadAvatar(image: UIImage, userId: String) async throws -> URL {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "Invalid image data", code: -1, userInfo: nil)
        }
        
        let storageRef = Storage.storage().reference().child("avatars/\(userId).jpg")
        return try await withCheckedThrowingContinuation { continuation in
            let _ = storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    storageRef.downloadURL { url, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else if let url = url {
                            continuation.resume(returning: url)
                        }
                    }
                }
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
