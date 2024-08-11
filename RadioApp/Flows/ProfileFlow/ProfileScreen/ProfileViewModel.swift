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

enum ProfileFlowError: LocalizedError {
    // MARK: - Cases
    case logout
    case unknown(Error)
    
    // MARK: - Computed Properties
    
    /// Текущий язык, используемый в приложении
    var language: Language {
        LocalizationService.shared.language
    }
    
    /// Описание причины ошибки
    var failureReason: String? {
        switch self {
        case .logout:
            return Resources.Text.logOut.localized(language)
        case .unknown:
            return "Unknown"
        }
    }
    
    /// Описание ошибки для пользователя
    var errorDescription: String? {
        switch self {
        case .logout:
            return Resources.Text.areYouWantLogOut.localized(language)
        case .unknown(let error):
            return error.localizedDescription
        }
    }
    
    /// Предложение по восстановлению после ошибки
    var recoverySuggestion: String? {
        return "recovery"
    }
    
    /// Якорь справки, предоставляющий дополнительную информацию
    var helpAnchor: String? {
        return "help anchor"
    }
    
    // MARK: - Static Methods
    
    /// Функция для маппинга ошибки в `ProfileFlowError`
    /// - Parameter error: Ошибка для маппинга
    /// - Returns: Маппированная ошибка `ProfileFlowError`
    static func map(_ error: Error) -> ProfileFlowError {
        return error as? ProfileFlowError ?? .unknown(error)
    }
}

final class ProfileViewModel: ObservableObject {
    // MARK: - Stored Properties
    @Published var currentUser: UserModel?
    @Published var error: ProfileFlowError?
    @AppStorage("isOnboarding") var isOnboarding = true
    
    var userName: String { currentUser?.userName ?? "" }
    var userEmail: String { currentUser?.email ?? "" }
    //    var profileImage: String { currentUser?.profileImage }
    
    private let authService: AuthService
    private let firebaseStorage: FirebaseStorageService
    private let notificationsService: NotificationsService
    
    // MARK: - Initializer
    init(
        authService: AuthService = .shared,
        firebaseStorage: FirebaseStorageService = .shared,
        notificationsService: NotificationsService = .shared) {
            self.authService = authService
            self.firebaseStorage = firebaseStorage
            self.notificationsService = notificationsService
            
            fetchUser()
        }
    
    // MARK: - Methods
    func showLogoutAlert() { error = .logout }
    func cancelErrorAlert() { error = nil }
    
    func tapErrorOk() {
        switch error {
        case .logout:
            logOut()
        default: return
        }
    }
        
    // MARK: - Storage Methods
    func getProfileImage(path: String) {
        guard currentUser != nil else { return }
        Task {
            try await firebaseStorage.getUrlForImage(path: path)
        }
    }
    
    //    MARK: - AuthService Methods
    func fetchUser() {
        Task {
            currentUser = authService.getCurrentUserModel()
        }
    }
    
    func logOut() {
        do {
            try authService.signUserOut()
            isOnboarding.toggle()
        } catch {
            Task {
                self.error = ProfileFlowError.map(error)
            }
        }
    }
    
    //    MARK: - Notifications
    func notificationAction() {
        notificationsService.sendTestNotification()
    }
}
