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
import GoogleSignIn
import GoogleSignInSwift

@main
struct RadioAppApp: App {
    @StateObject var appManager = ViewModel()
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            TestAuthView()
            SignInView()
//            ProfileView(viewModel: ProfileViewModel())
           // TestAuthView()
            //TestVoteCoreDataView()
                .environmentObject(appManager)
            //CoreData
                .environment(\.managedObjectContext, appManager.container.viewContext)
        }
    }
}
