//
//  StartService.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 09.08.2024.
//
import SwiftUI

// MARK: - Context
final class ContextForStart: ObservableObject {
    private let authService = AuthService.shared
    
    @AppStorage("isOnboarding") var isOnboardComplete = false
    
    init() {}
    
    func isAuth() -> Bool {
        return authService.isAuthenticated()
    }
}

// MARK: - IStartService Protocol

protocol IStartService {
    func selectStartFlow(context: ContextForStart) -> AnyView
}

// MARK: - StartService Implementation

final class StartService: IStartService {
    func selectStartFlow(context: ContextForStart) -> AnyView {
        if !context.isOnboardComplete {
            return AnyView(WelcomeView())
        } else if context.isAuth() {
            return AnyView(ContentView())
        } else {
            return AnyView(SignInView())
        }
    }
}
