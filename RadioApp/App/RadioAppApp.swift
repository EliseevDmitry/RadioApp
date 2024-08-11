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
   // let container = NSPersistentContainer(name: "LikeStations")
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
   //MARK: -
//    init(){
//        container.loadPersistentStores{description, error in
//            if let error = error {
//                print("CoreData failed to load \(error.localizedDescription)")
//            }
//        }
//    }
    var body: some Scene {
        WindowGroup {
            if !isOnboarding {
                WelcomeView(appManager: appManager)
                    .preferredColorScheme(.dark)
                   // .environmentObject(appManager)
            } else if AuthService.shared.isAuthenticated() {
            
                ContentView(appManager: appManager)
                    .preferredColorScheme(.dark)
                    //.environmentObject(appManager)
            } else {
                SignInView(appManager: appManager)
                    .preferredColorScheme(.dark)
                    //.environmentObject(appManager)
            }
            
        }
    }
}
