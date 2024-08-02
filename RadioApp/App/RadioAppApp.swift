//
//  RadioAppApp.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI
import AVFAudio

@main
struct RadioAppApp: App {
    @StateObject var appManager = ViewModel()
    //audio
    init() {
        try? AVAudioSession.sharedInstance().setActive(true)
    }
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(appManager)
        }
    }
}
