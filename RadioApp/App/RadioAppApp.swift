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
    //MARK: - PROPERTIES
    @StateObject var appManager = ViewModel()
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //MARK: - BODY
    var body: some Scene {
        WindowGroup {
            TransitView(appManager: appManager)
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, appManager.container.viewContext)
        }
    }
}
