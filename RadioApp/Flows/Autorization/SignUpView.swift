//
//  SignUpView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

struct SignUpView: View {    
    @EnvironmentObject var appManager: ViewModel
    
    private struct DrawingConstants {
        // размеры - адаптивные: привязаны к ширине и высоте экрана (UIScreen)
        static let screenLogoImageWidth = UIScreen.width * 1/4
        static let screenLogoImageHeight = UIScreen.width * 1/4
        static let screenTitleFontSize = UIScreen.height * 1/16
        static let screenTitleBottomPadding = UIScreen.height * 1/32
        static let screenSubTitleFontSize = UIScreen.height * 1/48
        static let screenSubTitleFrameWidth = UIScreen.width * 1/3
    }
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView(screenType: .authentication)
            AuthBackgroundView()
            
            VStack(alignment: .leading) {
                Spacer()
                
                Image("Group 3").resizable()
                    .frame(width: DrawingConstants.screenLogoImageWidth,
                           height: DrawingConstants.screenLogoImageHeight)
                Text(Resources.Text.signUp)
                    .font(.custom(.sfBold, size: DrawingConstants.screenTitleFontSize))
                    .padding(.bottom, DrawingConstants.screenTitleBottomPadding)
                
                Text(Resources.Text.toStartPlay)
                    .font(.custom(.sfRegular, size: DrawingConstants.screenSubTitleFontSize))
                    .frame(maxWidth: DrawingConstants.screenSubTitleFrameWidth)
                
                TextField(Resources.Text.name, text: $appManager.email)
                    .font(.title)
                
                TextField(Resources.Text.email, text: $appManager.email)
                    .font(.title)
                
                SecureField(Resources.Text.password, text: $appManager.password)
                    .font(.title)
                                
                CustomButton(action: appManager.registerUser, title: Resources.Text.signUp, buttonType: .onboarding) // TODO: изменить тип кнопки
                
                /*
                Button(action: {}) {
                    Text(Resources.Text.orSignIn)
                        .foregroundStyle(.white)
                }
                */
                
                NavigationLink(
                    destination: SignInView()
                        .environmentObject(appManager)
                        .navigationBarBackButtonHidden()
                ) {
                    Text(Resources.Text.orSignIn)
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

