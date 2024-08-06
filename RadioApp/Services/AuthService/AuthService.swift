//
//  AuthService.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 01.08.2024.
//

import Foundation
import FirebaseAuth
import Firebase

//this service class will consist of login, sign up and logout auth

final class AuthService {
    static let shared = AuthService()
    
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
    
    func updateEmail(_ email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "No user is signed in", code: -1, userInfo: nil)
        }
        
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
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
