//
//  RadioAppApp.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI
import AVFAudio
import FirebaseCore
import FirebaseAuth

@main
struct RadioAppApp: App {
    //MARK: -
    @AppStorage("isOnboarding") var isOnboarding = false
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
   //MARK: -
    var body: some Scene {
        WindowGroup {
            if !isOnboarding {
                WelcomeView()
                    .preferredColorScheme(.dark)
            } else if AuthService.shared.isAuthenticated() {
             ContentView()
                        .preferredColorScheme(.dark)
               
            } else {
                SignInView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
