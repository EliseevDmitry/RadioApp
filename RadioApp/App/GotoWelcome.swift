//
//  GotoWelcome.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 12.08.2024.
//

import SwiftUI

struct GotoWelcome: View {
    @ObservedObject var appManager: ViewModel
    @AppStorage("isOnboarding") var isOnboarding = true
    var body: some View {
        VStack{
            Button("GoToHome"){
                appManager.signOut()
                isOnboarding = false
                appManager.tagSelection = "view1"
            }
        }
    }
}

#Preview {
    GotoWelcome(appManager: ViewModel())
}
