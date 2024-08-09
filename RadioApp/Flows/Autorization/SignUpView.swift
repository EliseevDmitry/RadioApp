//
//  SignUpView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

// MARK: - SignInView
struct SignUpView: View {
    // MARK: - Properties
    @EnvironmentObject var appManager: ViewModel
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let screenLogoImageWidth = UIScreen.width * 1/6
        static let screenLogoImageHeight = screenLogoImageWidth
        static let screenTitleFontSize = UIScreen.height * 1/16
        static let screenTitleBottomPadding = UIScreen.height * 1/32
        static let screenSubtitleFontSize = UIScreen.height * 1/48
        static let screenSubtitleFrameWidth = UIScreen.width * 1/3
        static let screenSubtitleBottomPadding = UIScreen.height * 1/16
        static let screenContentPadding = UIScreen.width * 1/16
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: Background
            AnimatedBackgroundView(screenType: .authentication)
            AuthBackgroundView()
            
            VStack(alignment: .leading) {
                Spacer()
                
                // MARK: Logo
                Image("playButtonLogo").resizable()
                    .frame(width: DrawingConstants.screenLogoImageWidth,
                           height: DrawingConstants.screenLogoImageHeight)
                
                // MARK: Title
                Text(Resources.Text.signUp)
                    .font(.custom(.sfBold, size: DrawingConstants.screenTitleFontSize))
                    .padding(.bottom, DrawingConstants.screenTitleBottomPadding)
                    .foregroundStyle(.white)
                
                // MARK: Subtitle
                Text(Resources.Text.toStartPlay)
                    .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
                    .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
                    .foregroundStyle(.white)
                    .padding(.bottom, DrawingConstants.screenSubtitleBottomPadding)
                
                // MARK: Name Textfield
                Text(Resources.Text.name)
                    .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
                    .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
                    .foregroundStyle(.white)
                
                TextField(Resources.Text.yourName, text: $appManager.username)
                    .font(.title)
                    .background(.white)
                
                // MARK: Email Textfield
                Text(Resources.Text.email)
                    .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
                    .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
                    .foregroundStyle(.white)
                
                TextField(Resources.Text.yourEmail, text: $appManager.email)
                    .font(.title)
                    .background(.white)
                
                // MARK: Password Securefield
                Text(Resources.Text.password)
                    .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
                    .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
                    .foregroundStyle(.white)
                
                SecureField(Resources.Text.yourPassword, text: $appManager.password)
                    .font(.title)
                    .background(.white)
                                
                // MARK: SignUp Button
                CustomButton(action: appManager.registerUser, title: Resources.Text.signUp, buttonType: .authentication)
                
                // MARK: SignIn Button
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
            .padding(DrawingConstants.screenContentPadding)
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

