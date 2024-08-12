//
//  SignUpView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

// MARK: - SignUpView
struct SignUpView: View {
    // MARK: - Properties
    @StateObject var viewModel: AuthViewModel
    
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
            // Background Views
            AnimatedBackgroundView()
            AuthBackgroundView()
            
            // Content
            VStack(alignment: .leading) {
                Spacer()
                
                // App Logo
                Image("Group 3")
                    .resizable()
                    .frame(width: UIScreen.width * 1/4, height: UIScreen.width * 1/4)
                
                // Title Text
                Text(Resources.Text.SignUp.title)
                    .font(.custom(.sfBold, size: UIScreen.height * 1/16))
                    .padding(.bottom, UIScreen.height * 1/32)
                
                // Subtitle Text
                Text(Resources.Text.SignUp.toStartPlay)
                    .font(.custom(.sfRegular, size: UIScreen.height * 1/48))
                    .frame(maxWidth: UIScreen.width * 1/3)
                
                // Input Fields
                TextField(Resources.Text.SignUp.name, text: $viewModel.email) // Note: Should probably be $viewModel.username
                    .font(.title)
                
                TextField(Resources.Text.SignUp.email, text: $viewModel.email)
                    .font(.title)
                
                SecureField(Resources.Text.SignUp.password, text: $viewModel.password)
                    .font(.title)
                                
                // Register Button
                CustomButton(action: viewModel.registerUser, title: Resources.Text.SignUp.title, buttonType: .onboarding)
                // TODO: изменить тип кнопки
                
                // Sign In Button
                Button(action: {}) {
                    Text(Resources.Text.SignUp.orSignIn)
                        .foregroundStyle(.white)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    SignUpView()
}
