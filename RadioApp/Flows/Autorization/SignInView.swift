//
//  SignInView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

// MARK: - SignInView
struct SignInView: View {
    @EnvironmentObject var appManager: ViewModel
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        // размеры - адаптивные: привязаны к ширине и высоте экрана (UIScreen)
        static let screenLogoImageWidth = UIScreen.width * 1/4
        static let screenLogoImageHeight = UIScreen.width * 1/4
        static let screenTitleFontSize = UIScreen.height * 1/16
        static let screenTitleBottomPadding = UIScreen.height * 1/32
        static let screenSubtitleFontSize = UIScreen.height * 1/48
        static let screenSubtitleFrameWidth = UIScreen.width * 1/3
    }
    
    // MARK: - Body
    var body: some View {
            ZStack {
                AnimatedBackgroundView(screenType: .authentication)
                AuthBackgroundView()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Image("Group 3").resizable()
                        .frame(width: DrawingConstants.screenLogoImageWidth,
                               height: DrawingConstants.screenLogoImageHeight)
                    Text(Resources.Text.signIn)
                        .font(.custom(.sfBold, size: DrawingConstants.screenTitleFontSize))
                        .padding(.bottom, DrawingConstants.screenTitleBottomPadding)
                    
                    Text(Resources.Text.toStartPlay)
                        .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
                        .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
                    
                    TextField(Resources.Text.email, text: $appManager.email)
                        .font(.title)
                    
                    SecureField(Resources.Text.password, text: $appManager.password)
                        .font(.title)
                    
                    /*
                    NavigationLink(destination: ForgotPassOneView().environmentObject(appManager)) {
                            Text(Resources.Text.forgotPassword)
                                .foregroundStyle(.white)
                    }
                    */
                    
                    NavigationLink(
                        destination: ForgotPassOneView()
                            .navigationBarBackButtonHidden()
                            .environmentObject(appManager)
                    ) {
                        Text(Resources.Text.forgotPassword)
                            .foregroundStyle(.white)
                    }
                    
                    HStack {
                        Rectangle()
                            .frame(width: 50, height: 1)
                        Text(Resources.Text.orConnectWith)
                        Rectangle()
                            .frame(width: 50, height: 1)
                    }
                    
                    
                    Button(action: appManager.signInWithGoogle) {
                        Text("G+")
                            .foregroundStyle(.white)
                    }
                    
                    // MARK: SignIn Button
                    NavigationLink(isActive: $appManager.isSignedIn) {
                        PopularView()
                            .navigationBarBackButtonHidden()
//                            .environmentObject(appManager)
                    } label: {
                        CustomButton(
                            action: {
                                /*
                                if (AuthService.userSession != nil) {
                                    
                                }
                                appManager.isSignedIn = true
                                appManager.signIn()
                                */
                                
                                appManager.isSignedIn.toggle()
                                appManager.signIn()
                            },
                            title: Resources.Text.signIn,
                            buttonType: .authentication)
                    }
                    
                    /*
                     CustomButton(action: appManager.signIn, title: Resources.Text.signIn, buttonType: .authentication)
                     */
                    
                    /*
                    NavigationLink(destination: SignUpView().environmentObject(appManager)) {
                            Text(Resources.Text.orSignUp)
                                .foregroundStyle(.white)
                    }
                    */
                    
                    // MARK: SignUp Button
                    NavigationLink(
                        destination: SignUpView()
                            .environmentObject(appManager)
                            .navigationBarBackButtonHidden()
                    ) {
                        Text(Resources.Text.orSignUp)
                            .foregroundStyle(.white)
                        /*
                        CustomButton(
                            action: {},
                            title: Resources.Text.getStarted,
                            buttonType: .onboarding)
                        */
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
        Group {
            SignInView()
                .environmentObject(previewAppManager)
            SignInView()
                .environmentObject(previewAppManager)
                .preferredColorScheme(.dark)
        }
    }
}

