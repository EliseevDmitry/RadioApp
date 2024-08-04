//
//  SignInView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appManager: ViewModel
    
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
                
                CustomButton(action: appManager.signIn, title: Resources.Text.SignIn.title, buttonType: .onboarding) 
                // TODO: добавить в типы кнопок третий тип - для этой группы экранов и при выборе типа заменить тернарный оператор на switch (обсудить с Димой Келлером)
                
                Button(action: {}) {
                    Text(Resources.Text.SignIn.orSignUp)
                        .foregroundStyle(.white)
                }
                
                Spacer()
            }
            .padding()
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

