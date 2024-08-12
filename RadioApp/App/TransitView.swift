//
//  TransitView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 12.08.2024.
//

import SwiftUI

struct TransitView: View {
    @AppStorage("isOnboarding") var isOnboarding = false
    @ObservedObject var appManager: ViewModel
    var body: some View {
        NavigationView{
            VStack{
                if !isOnboarding {
                    NavigationLink(destination: WelcomeView(appManager: appManager).navigationBarBackButtonHidden(true), tag: "view1", selection: $appManager.tagSelection) { }
                } else if appManager.authService.userSession != nil {
                    NavigationLink(destination: ContentView(appManager: appManager).navigationBarBackButtonHidden(true), tag: "view2", selection: $appManager.tagSelection) { }
                } else {
                    NavigationLink(destination: SignInView(appManager: appManager).navigationBarBackButtonHidden(true), tag: "view3", selection: $appManager.tagSelection) { }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(.stack)
        }
    }
    
}

#Preview {
    TransitView(appManager: ViewModel())
}
