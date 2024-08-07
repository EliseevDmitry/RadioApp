//
//  AuthService.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 01.08.2024.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import GoogleSignIn

//this service class will consist of login, sign up and logout auth

final class AuthService {
    static let shared = AuthService()
    
    var errorMessage = ""
    
    @Published var userSession: FirebaseAuth.User?
    
    private init() {
        self.userSession = Auth.auth().currentUser
        print("userSession\(userSession)")
    }
    
    func registerUser(with email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("\(result.user.uid)")
            self.userSession = result.user
        } catch {
            print("DEBUG: Could not register the user")
        }
    }
    
    func signIn(with email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            print("DEBUG: Successfully signed user in: \(result.user.uid)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func getCurrentUserModel() -> UserModel? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return UserModel(
            id: user.uid,
            userName: user.displayName ?? "",
            email: user.email ?? "",
            avatarURL: user.photoURL?.absoluteString
        )
    }
    
    func updateUserProfile(displayName: String?, photoURL: URL?) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "No user is signed in", code: -1, userInfo: nil)
        }
        
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = displayName
        changeRequest.photoURL = photoURL
        
        try await changeRequest.commitChanges()
    }
    
    func uploadAvatar(image: UIImage, userId: String) async throws -> URL {
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
    
    func updateEmail(_ email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "No user is signed in", code: -1, userInfo: nil)
        }
        
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    
//    func signUserOut() throws { // ошибка при копировании
    
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
            print("There is no root view controller")
            return false
        }
        
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                throw AuthenticationError.tokenError(message: "ID token missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            return true
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            return false
        }
        
//        return false
    }
    
    func signUserOut() throws {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            throw error
        }
    }
}

enum AuthenticationError: Error {
    case tokenError(message: String)
}

