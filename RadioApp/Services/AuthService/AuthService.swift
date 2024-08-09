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

// This service class will consist of login, sign up and logout auth

final class AuthService {
    // MARK: - Properties
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    // MARK: - Initializer
    private init() {
        self.userSession = Auth.auth().currentUser
        print("userSession\(userSession)")
    }
    
    // MARK: - Methods
    func isAuthenticated() -> Bool {
        return Auth.auth().currentUser?.uid != nil
    }
    
    /// Registers a new user with the given email, password, and username
    /// - Parameters:
    ///   - email: The email of the new user
    ///   - password: The password of the new user
    ///   - username: The username of the new user
    func registerUser(with email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("\(result.user.uid)")
            self.userSession = result.user
        } catch {
            print("DEBUG: Could not register the user")
        }
    }
    
    /// Signs in a user with the given email and password
    /// - Parameters:
    ///   - email: The email of the user
    ///   - password: The password of the user
    func signIn(with email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            print("DEBUG: Successfully signed user in: \(result.user.uid)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Gets the current user model
    /// - Returns: A UserModel instance representing the current user, or nil if no user is signed in
    func getCurrentUserModel() -> UserModel? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return UserModel(
            id: user.uid,
            userName: user.displayName ?? "",
            email: user.email ?? "",
            profileImagePath: user.photoURL?.absoluteString
        )
    }
    
    /// Updates the current user's profile with the given display name and photo URL
    /// - Parameters:
    ///   - displayName: The new display name for the user
    ///   - photoURL: The new photo URL for the user
    func updateUserProfile(displayName: String?, photoURL: URL?) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "No user is signed in", code: -1, userInfo: nil)
        }
        
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = displayName
        changeRequest.photoURL = photoURL
        
        try await changeRequest.commitChanges()
    }
    
    /// Updates the email of the current user
    /// - Parameter email: The new email for the user
    func updateEmail(_ email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "No user is signed in", code: -1, userInfo: nil)
        }
        
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    /// Signs out the current user
    func signUserOut() throws {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            throw error
        }
    }

    private func userReferance(userID: String) -> StorageReference {
        storage.child("users").child(userID)
    }
    
    func getUrlForImage(path: String) async throws -> URL {
        try await Storage.storage().reference(withPath: path).downloadURL()
    }
    
    func getData(userID: String, path: String) async throws -> Data {
        try await storage.child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
    func getImage(userID: String, path: String) async throws -> UIImage {
        let data = try await getData(userID: userID, path: path)
        
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        return image
    }
    
    func saveImage(data: Data, userID: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await userReferance(userID: userID).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        return (returnedPath, returnedName)
    }
    
    func saveImage(image: UIImage, userID: String) async throws -> (path: String, name: String) {
        guard let data = image.jpegData(compressionQuality: 1) else {
            throw URLError(.backgroundSessionWasDisconnected)
        }
        
        return try await saveImage(data: data, userID: userID)
    }
    
}
