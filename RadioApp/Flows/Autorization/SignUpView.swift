//
//  SignUpView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

struct SignUpView: View {    
    @StateObject var viewModel: AuthViewModel
    
    init(
        authService: AuthService = .shared
    ) {
        self._viewModel = StateObject(
            wrappedValue: AuthViewModel(
                authService: authService
            )
        )
    }
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            AuthBackgroundView()
            
            VStack(alignment: .leading) {
                Spacer()
                
                Image("Group 3").resizable()
                    .frame(width: UIScreen.width * 1/4, height: UIScreen.width * 1/4)
                Text(Resources.Text.SignUp.title)
                    .font(.custom(.sfBold, size: UIScreen.height * 1/16))
                    .padding(.bottom, UIScreen.height * 1/32)
                
                Text(Resources.Text.SignUp.toStartPlay)
                    .font(.custom(.sfRegular, size: UIScreen.height * 1/48))
                    .frame(maxWidth: UIScreen.width * 1/3)
                
                TextField(Resources.Text.SignUp.name, text: $viewModel.email)
                    .font(.title)
                
                TextField(Resources.Text.SignUp.email, text: $viewModel.email)
                    .font(.title)
                
                SecureField(Resources.Text.SignUp.password, text: $viewModel.password)
                    .font(.title)
                                
                CustomButton(action: viewModel.registerUser, title: Resources.Text.SignUp.title, buttonType: .onboarding)
                // TODO: изменить тип кнопки
                
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

