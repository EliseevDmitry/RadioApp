//
//  SignInView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

struct SignInView: View {
    // MARK: - Properties
    @ObservedObject var appManager: ViewModel
    @State private var isAuthenticated = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // MARK: - Body
    
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
    
    
    var body: some View {
        NavigationView {
            ZStack {
                //Backgrounds
                AnimatedBackgroundView()
                AuthBackgroundView()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
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
        .navigationViewStyle(.stack)
        //        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
    // MARK: - Subviews
    private var background: some View {
        ZStack {
            AnimatedBackgroundView()
            AuthBackgroundView()
        }
    }
    
    private var appLogo: some View {
        Image("toolbarplay")
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
            TextFieldForEmailView(appManager: appManager)
            FieldForPasswordView(appManager: appManager)
        }
    }
    
    private var forgotPasswordButton: some View {
        HStack {
            Spacer()
            Button(action: {
                NavigationLink(destination: ForgotPassOneView(appManager: appManager)) {
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
                    do {
                        try await appManager.test()
                    } catch {
                        // Обработка ошибки
                        print("Ошибка при выполнении test(): (error)")
                    }
                }
            },
            title: Resources.Text.signIn,
            buttonType: .onboarding
        )
        .frame(maxWidth: DrawingConstants.signInButtonWidth)
        .padding(.vertical, DrawingConstants.verticalPaddingSize)
    }
    
    private var signUpButton: some View {
        NavigationLink {
            SignUpView(appManager: appManager).navigationBarBackButtonHidden(true)
        } label: {
            Text(Resources.Text.orSignUp)
                //.padding(.vertical, DrawingConstants.verticalPaddingSize)
                .padding(.bottom, 10)
                .tint(.white)
        }
        
        }
    
    
    //    private var signInButton: some View {
    //                CustomButton(action: {
    //                    Task {
    //                            do {
    //                                try await appManager.test()
    //                            } catch {
    //                                // Обработка ошибки
    //                                print("Ошибка при выполнении test(): (error)")
    //                            }
    //                        }
    //                },
    //                             title: Resources.Text.SignIn.title,
    //                             buttonType: .onboarding
    //                )
    
    
    
    //        return Button(Resources.Text.SignIn.title){
    //                Task {
    //                        do {
    //                            try await appManager.test()
    //                        } catch {
    //                            // Обработка ошибки
    //                            print("Ошибка при выполнении test(): (error)")
    //                        }
    //                    }
    //            }
    
    
    
    
}

private var signUpButton: some View {
    Button(action: {}) {
        Text(Resources.Text.orSignUp)
            .foregroundStyle(.white)
    }
}

// MARK: - Functions
//    private func signIn() async {
//        await appManager.signIn()
//        if let error = await appManager.error {
//            alertMessage = error.localizedDescription
//            showAlert = true
//
//        } else {
//            isAuthenticated = true
//        }
//    }



// MARK: - Previews
struct SignInView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        SignInView(appManager: previewAppManager)
        
    }
}
