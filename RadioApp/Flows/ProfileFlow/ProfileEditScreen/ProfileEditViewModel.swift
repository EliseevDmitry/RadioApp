//
//  ProfileEditViewModel.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 11.08.2024.
//

import SwiftUI

final class ProfileEditViewModel: ObservableObject {
    
    @Published var currentUser: UserModel?
    @Published var error: ProfileFlowError?
    
    private let authService: AuthService
    private let firebaseStorage: FirebaseStorageService

    // MARK: - Initializer
    init(authService: AuthService, firebaseStorage: FirebaseStorageService) {
        self.authService = authService
        self.firebaseStorage = firebaseStorage
    }
    
    func saveProfileImage(_ image: UIImage) {
        guard let currentUser else { return }
        
        Task {
            let (_, _) = try await firebaseStorage.saveImage(image: image, userID: currentUser.id) //let (path, name)
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
                

            } catch {
                    self.error = ProfileFlowError.map(error)
            }
        }
    }
}
