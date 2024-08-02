//
//  RadioAppApp.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct RadioAppApp: App {
    @StateObject var appManager = ViewModel()
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            TestAuthView()
                .environmentObject(appManager)
        }
    }
}
