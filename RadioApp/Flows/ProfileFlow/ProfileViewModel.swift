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
    
    // MARK: - Initializer
    init() {
        notification()
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
            let (path, name) = try await authService.saveImage(image: image, userID: currentUser.id)
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
    
    func notification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func notificationAction() {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
