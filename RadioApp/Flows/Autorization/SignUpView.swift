//
//  SignUpView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

struct SignUpView: View {    
    @EnvironmentObject var appManager: ViewModel
    
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
                
                TextField(Resources.Text.SignUp.name, text: $appManager.email)
                    .font(.title)
                
                TextField(Resources.Text.SignUp.email, text: $appManager.email)
                    .font(.title)
                
                SecureField(Resources.Text.SignUp.password, text: $appManager.password)
                    .font(.title)
                                
                CustomButton(action: appManager.registerUser, title: Resources.Text.SignUp.title, buttonType: .onboarding)
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

struct SignUpView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        SignUpView()
            .environmentObject(previewAppManager)
    }
}

