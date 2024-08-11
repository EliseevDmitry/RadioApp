//
//  AuthManager.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 08.08.2024.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    /// Метод позволяет получить аутентифицированного пользователя без обращения к серверу Firebase. Если пользователь уже прошел аутентификацию, то метод вернет данные о нем в виде экземпляра структуры AuthDataResultModel. Если нет, - выдаст сообщение об ошибке
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            print("Не удалось получить данные о том, прошел ли текущий пользователь аутентификацию в приложении якобы из-за ошибки сервера Firebase. Однако, на самом деле это значит, что пользователь не аутентифицирован.")
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    /// Метод позволяет создать нового пользователя на сервере Firebase с помощью электронной почты и пароля. Если создать пользователя получится метод вернет данные о нем в виде экземпляра структуры AuthDataResultModel.
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    /// Метод позволяет залогиниться - войти в систему с помощью электронной почты и пароля.
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    /// Метод позволяет сбросить пароль для пользователя с определенной электронной почтой
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    /// Метод позволяет обновить пароль для текущего пользователя
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: password)
    }
    
    /*
    /// Метод позволяет обновить электронную почту для текущего пользователя
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updateEmail(to: email)
    }
    */
    
    /// Метод позволяет пользователю разлогиниться
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
