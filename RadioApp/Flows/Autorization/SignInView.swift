//
//  SignInView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

struct SignInView: View {
    // MARK: - Properties
    @EnvironmentObject var appManager: ViewModel
    
    @State private var isAuthenticated = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            
            ZStack {
                // Backgrounds
                AnimatedBackgroundView()
                AuthBackgroundView()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    appLogo
                    
                    titleText
                    
                    subtitleText
                    
                    inputFields
                    
                    socialMediaButton
                    
                    signInButton
                    
                    signUpButton
                    
                    Spacer()
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    // MARK: - Subviews
    private var appLogo: some View {
        Image("Group 3")
            .resizable()
            .frame(width: UIScreen.width * 1/4, height: UIScreen.width * 1/4)
    }
    
    private var titleText: some View {
        Text(Resources.Text.SignIn.title)
            .font(.custom(.sfBold, size: UIScreen.height * 1/16))
            .padding(.bottom, UIScreen.height * 1/32)
    }
    
    private var subtitleText: some View {
        Text(Resources.Text.SignIn.toStartPlay)
            .font(.custom(.sfRegular, size: UIScreen.height * 1/48))
            .frame(maxWidth: UIScreen.width * 1/3)
    }
    
    private var inputFields: some View {
        VStack {
            TextField(Resources.Text.SignIn.email, text: $appManager.email)
                .font(.title)
            
            SecureField(Resources.Text.SignIn.password, text: $appManager.password)
                .font(.title)
        }
    }
    
    private var socialMediaButton: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Resources.Text.SignIn.orConnectWith)
            
            Button(action: {}) {
                Text("G+")
                    .foregroundStyle(.white)
            }
        }
    }
    
    private var signInButton: some View {
        CustomButton(action: {
            Task {
                await signIn()
            }
        },
                     title: Resources.Text.SignIn.title,
                     buttonType: .onboarding
        )
        .background(
            NavigationLink(destination: ContentView(), isActive: $isAuthenticated) {
                EmptyView()
            }
        )
    }
    
    private var signUpButton: some View {
        Button(action: {}) {
            Text(Resources.Text.SignIn.orSignUp)
                .foregroundStyle(.white)
        }
    }
    
    // MARK: - Functions
    private func signIn() async {
        await appManager.signIn()
        if let error = appManager.error {
            alertMessage = error.localizedDescription
            showAlert = true
            
        } else {
            isAuthenticated = true
        }
    }
}

// MARK: - Previews
struct SignInView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        SignInView()
            .environmentObject(previewAppManager)
    }
}
