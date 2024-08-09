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
    @StateObject var appManager = ViewModel()
    @AppStorage("isOnboarding") var isOnboarding = false
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if !isOnboarding {
                WelcomeView()
                    .preferredColorScheme(.dark)
                    .environmentObject(appManager)
            } else if AuthService.shared.isAuthenticated() {
                ContentView()
                    .preferredColorScheme(.dark)
                    .environmentObject(appManager)
                    .environment(\.managedObjectContext, appManager.container.viewContext)
            } else {
                SignInView()
                    .preferredColorScheme(.dark)
                    .environmentObject(appManager)
            }
        }
    }
}
