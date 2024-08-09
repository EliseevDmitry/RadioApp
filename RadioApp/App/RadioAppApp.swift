//
//  RadioAppApp.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI
import AVFAudio
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

@main
struct RadioAppApp: App {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    @StateObject var appManager = ViewModel()
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            /*
             // это вариант настройки, при которой если онбординг не пройден, то сначала показывают экран WelcomeView и далее экран SignIn, а если онбординг пройден, то показывают экран SignInView вне зависимости от аутентификации пользователя (независимо от того, залогинен ли пользователь)
            NavigationView {
                if appManager.onboardingIsShown {
                    SignInView()
                        .environmentObject(appManager)
                        .environment(\.managedObjectContext, appManager.container.viewContext)
                } else {
                    WelcomeView()
                        .environmentObject(appManager)
                        .environment(\.managedObjectContext, appManager.container.viewContext)
                }
            }
            .navigationViewStyle(.stack)
            */
            
            /*
            // это вариант настройки, при которой если онбординг не пройден
            NavigationView {
                if appManager.onboardingIsShown, !appManager.showSignInView {
                    PopularView()
                        .environmentObject(appManager)
                        .environment(\.managedObjectContext, appManager.container.viewContext)
                } else if appManager.onboardingIsShown, appManager.showSignInView {
                    SignInView()
                        .environmentObject(appManager)
                        .environment(\.managedObjectContext, appManager.container.viewContext)
                } else {
                    WelcomeView()
                        .environmentObject(appManager)
                        .environment(\.managedObjectContext, appManager.container.viewContext)
                }
            }
            .navigationViewStyle(.stack)
            */
            
             // это вариант настройки
            RootView()
                .environmentObject(appManager)
                .environment(\.managedObjectContext, appManager.container.viewContext)
        }
    }
}
