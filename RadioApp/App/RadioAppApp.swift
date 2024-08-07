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
            if appManager.onboardingIsShown {
               SignInView()
                    .environmentObject(appManager)
                    .environment(\.managedObjectContext, appManager.container.viewContext)
            } else {
               WelcomeView()
                    .environmentObject(appManager)
                    .environment(\.managedObjectContext, appManager.container.viewContext)
            }
            
//            ContentView()
//            TestAuthView()
            
//            SignInView()
//            WelcomeView()
//            ProfileView(viewModel: ProfileViewModel())
           // TestAuthView()
            //TestVoteCoreDataView()
//                .environmentObject(appManager)
            //CoreData
//                .environment(\.managedObjectContext, appManager.container.viewContext)
        }
    }
}
