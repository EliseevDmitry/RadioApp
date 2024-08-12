//
//  SignInView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

// MARK: - SignInView
struct SignInView: View {
    // MARK: - Properties
    @StateObject var viewModel: AuthViewModel
    @State private var alertMessage = ""
    
    // MARK: - Initializer
    init(
        authService: AuthService = .shared
    ) {
        self._viewModel = StateObject(
            wrappedValue: AuthViewModel(
                authService: authService
            )
        )
    }
    
    // MARK: - Body
    var body: some View {
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
            .alert(isPresented: isPresentedAlert()) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? ""),
                    dismissButton: .default(Text("OK"),
                    action: viewModel.cancelErrorAlert)
                )
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
            TextField(Resources.Text.SignIn.email, text: $viewModel.email)
                .font(.title)
            
            SecureField(Resources.Text.SignIn.password, text: $viewModel.password)
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
        NavigationLink(destination: ContentView(), isActive: $viewModel.isAuthenticated) {
            CustomButton(action: {
                Task {
                    await signIn()
                }
            },
                         title: Resources.Text.SignIn.title,
                         buttonType: .onboarding
            )
        }
    }
    
    private var signUpButton: some View {
        Button(action: {}) {
            Text(Resources.Text.SignIn.orSignUp)
                .foregroundStyle(.white)
        }
    }
    
    // MARK: - Functions
    private func signIn() async {
        await viewModel.signIn()
    }
    
    private func isPresentedAlert() -> Binding<Bool> {
        Binding(get: { viewModel.error != nil },
                set: { isPresenting in
            if isPresenting { return }
        })
    }
}

// MARK: - Preview
#Preview {
    SignInView()
}
