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
import CoreData


@main
struct RadioAppApp: App {
    //MARK: -
    @StateObject var appManager = ViewModel()
    @AppStorage("isOnboarding") var isOnboarding = false
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
   //MARK: -

    var body: some Scene {
        WindowGroup {
            if !isOnboarding {
                WelcomeView(appManager: appManager)
                    .preferredColorScheme(.dark)
            } else if AuthService.shared.isAuthenticated() {
                ContentView(appManager: appManager)
                    .preferredColorScheme(.dark)
                //---------CoreData--------
                    //.environment(\.managedObjectContext, appManager.container.viewContext)
                //---------CoreData--------
            } else {
                SignInView(appManager: appManager)
                    .preferredColorScheme(.dark)
            }
            
        }
    }
}
