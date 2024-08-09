//
//  SignInView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appManager: ViewModel
    
    @State private var isAuthenticated = false
    @State private var showAlert = false
    @State private var alert: AnyAppAlert?
    @State private var errorAlert: AnyAppAlert? = nil
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            AuthBackgroundView()
            
            VStack(alignment: .leading) {
                Spacer()
                
                Image("Group 3").resizable()
                    .frame(width: UIScreen.width * 1/4, height: UIScreen.width * 1/4)
                Text(Resources.Text.SignIn.title)
                    .font(.custom(.sfBold, size: UIScreen.height * 1/16))
                    .padding(.bottom, UIScreen.height * 1/32)
                
                Text(Resources.Text.SignIn.toStartPlay)
                    .font(.custom(.sfRegular, size: UIScreen.height * 1/48))
                    .frame(maxWidth: UIScreen.width * 1/3)
                
                TextField(Resources.Text.SignIn.email, text: $appManager.email)
                    .font(.title)
                
                SecureField(Resources.Text.SignIn.password, text: $appManager.password)
                    .font(.title)
                
                Text(Resources.Text.SignIn.orConnectWith)
                
                Button(action: {}) {
                    Text("G+")
                        .foregroundStyle(.white)
                }
                
                CustomButton(action: {
                    Task {
                        await signIn()
                    }
                },
                             title: Resources.Text.SignIn.title,
                             buttonType: .onboarding
                )
                // TODO: добавить в типы кнопок третий тип - для этой группы экранов и при выборе типа заменить тернарный оператор на switch (обсудить с Димой Келлером)
                
                Button(action: {
                    
                }) {
                    Text(Resources.Text.SignIn.orSignUp)
                        .foregroundStyle(.white)
                        .showCustomAlert(alert: $alert)
                        .showCustomAlert(alert: $alert)
                        .background(
                            NavigationLink(destination: ContentView(), isActive: $isAuthenticated) { EmptyView() }
                        )
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func signIn() async {
        await appManager.signIn()
        if appManager.error != nil {
            alert = AnyAppAlert(error: appManager.error!)
            showAlert = true
        } else {
            isAuthenticated = true
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        SignInView()
            .environmentObject(previewAppManager)
    }
}

