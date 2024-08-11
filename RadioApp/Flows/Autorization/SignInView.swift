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
    @EnvironmentObject var appManager: ViewModel
    
    @State private var isAuthenticated = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let screenLogoImageWidth = UIScreen.width * 1/7
        static let screenLogoImageHeight = screenLogoImageWidth
        static let screenTitleFontSize = UIScreen.height * 1/24
        static let screenTitleBottomPadding = UIScreen.height * 1/32
        static let screenSubtitleFontSize = UIScreen.height * 1/36
        static let screenSubtitleFrameWidth = UIScreen.width * 1/3
        static let screenSubtitleBottomPadding = UIScreen.height * 1/16
        static let screenContentPadding = UIScreen.width * 1/16
        static let verticalPaddingSize = UIScreen.height * 1/54
        static let lineWidth = UIScreen.width * 1/5
        static let lineHeight = UIScreen.height * 1/160
        static let googleButtonWidth = screenLogoImageWidth
        static let googleButtonHeight = screenLogoImageHeight
        static let signInButtonWidth = UIScreen.width * 1/3
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            
            ZStack {
                // MARK: Background
                background
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    // MARK: Screen Content
                    appLogo
                    
                    titleText
                    
                    subtitleText
                    
                    inputFields
                    
                    forgotPasswordButton
                    
                    socialMediaButton
                    
                    signInButton
                    
                    signUpButton
                    
                    Spacer()
                }
                .padding(32)
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
    private var background: some View {
        ZStack {
            AnimatedBackgroundView(screenType: .authentication)
            AuthBackgroundView()
        }
    }
    
    private var appLogo: some View {
        Image("playButtonLogo")
            .resizable()
            .frame(
                width: DrawingConstants.screenLogoImageWidth,
                height: DrawingConstants.screenLogoImageHeight
            )
    }
    
    private var titleText: some View {
        HStack {
            Text(Resources.Text.signIn)
                .font(.custom(.sfBold, size: 
                                DrawingConstants.screenTitleFontSize))
                .foregroundColor(.white)
        }
    }
    
    private var subtitleText: some View {
        HStack {
            Text(Resources.Text.toStartPlay)
                .font(.custom(.sfMedium, size: DrawingConstants.screenSubtitleFontSize))
                .foregroundColor(.white)
            Spacer()
        }
    }
    
    private var inputFields: some View {
        VStack {
            TextFieldForEmailView()
            FieldForPasswordView()
        }
    }
    
    private var forgotPasswordButton: some View {
        HStack {
            Spacer()
            Button(action: {
                NavigationLink(destination: ForgotPassOneView()) {
                    EmptyView()
                }
            }) {
                Text("\(Resources.Text.forgotPassword) ?")
                    .foregroundStyle(.white)
                    .padding(.vertical, DrawingConstants.verticalPaddingSize)
            }
        }
    }
    
    private var socialMediaButton: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: DrawingConstants.lineWidth,
                           height: DrawingConstants.lineHeight)
                Text(Resources.Text.orConnectWith)
                Rectangle()
                    .frame(width: DrawingConstants.lineWidth,
                           height: DrawingConstants.lineHeight)
                Spacer()
            }
            .foregroundStyle(.gray)
            .font(.subheadline)
            .padding(.vertical, DrawingConstants.verticalPaddingSize)
            
            Button(action: {}) {
                ZStack {
                    Circle()
                        .foregroundStyle(DS.Colors.reddish)
                        .frame(width: DrawingConstants.googleButtonWidth,
                               height: DrawingConstants.googleButtonHeight)
                    Image("googlePlus")
                }
            }
        }
    }
    
    private var signInButton: some View {
        CustomButton(
            action: {
                Task {
                    await signIn()
                }
            },
            title: Resources.Text.signIn,
            buttonType: .authentication
        )
        .background(
            NavigationLink(
                destination: ContentView(),
                isActive: $isAuthenticated) {
                    EmptyView()
                }
        )
        .frame(maxWidth: DrawingConstants.signInButtonWidth)
        .padding(.vertical, DrawingConstants.verticalPaddingSize)
    }
    
    private var signUpButton: some View {
        Button(action: {}) {
            Text(Resources.Text.orSignUp)
                .foregroundStyle(.white)
        }
        .padding(.vertical, DrawingConstants.verticalPaddingSize)
    }
    
    // MARK: - Functions
    private func signIn() async {
        await appManager.signIn()
        if let error = appManager.error {
            alertMessage = error.localizedDescription
            showAlert = true
            appManager.clearError()
        } else {
            isAuthenticated = true
        }
    }
}

// MARK: - Previews
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
