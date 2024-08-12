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
    @Environment (\.dismiss) var dismiss
    @ObservedObject var appManager: ViewModel
    @State private var isAuthenticated = false
    
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
        static let signUpButtonWidth = UIScreen.width * 1/3
        static let verticalPaddingSize = UIScreen.height * 1/54
    }
    
    // MARK: - Body
    var body: some View {
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
                
                signUpButton
                
                signInButton
                
                Spacer()
            }
            .padding(32)
        }
    }
    
    // MARK: - Subviews
    private var background: some View {
        ZStack {
            AnimatedBackgroundView()
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
            Text(Resources.Text.signUp)
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
            TextFieldForNameView(appManager: appManager)
            TextFieldForEmailView(appManager: appManager)
            FieldForPasswordView(appManager: appManager)
        }
    }
    
    private var signUpButton: some View {
        CustomButton(action: {
            Task {
                do {
                    try await  appManager.testNewUser()
                } catch let err {
                    // Обработка ошибки
                    print("Ошибка при выполнении test(): (error) - \(err)")
                }
            }
        }, title: Resources.Text.signUp, buttonType: .onboarding)
        .frame(maxWidth: DrawingConstants.signUpButtonWidth)
        .padding(.vertical, DrawingConstants.verticalPaddingSize)
    }
    
    private var signInButton: some View {
        Button(action: {dismiss()}) {
            Text(Resources.Text.orSignIn)
                .foregroundStyle(.white)
                .padding(.vertical, DrawingConstants.verticalPaddingSize)
            
            
            //        NavigationLink(
            //            destination: SignInView(appManager: appManager)
            //                .environmentObject(appManager)
            //                .navigationBarBackButtonHidden()
            //        ) {
            //            Text(Resources.Text.orSignIn)
            //                .foregroundStyle(.white)
            //        }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        SignUpView(appManager: previewAppManager)
    }
}



















//import SwiftUI
//
//struct SignUpView: View {  
//    //MARK: - PROPERTIES
//    @Environment (\.dismiss) var dismiss
//    @ObservedObject var appManager: ViewModel
//    //MARK: - BODY
//    var body: some View {
//        ZStack {
//            AnimatedBackgroundView()
//            AuthBackgroundView()
//            VStack(alignment: .leading) {
//                Spacer()
//                Image("Group 3").resizable()
//                    .frame(width: UIScreen.width * 1/4, height: UIScreen.width * 1/4)
//                Text(Resources.Text.signUp)
//                    .font(.custom(.sfBold, size: UIScreen.height * 1/16))
//                    .padding(.bottom, UIScreen.height * 1/32)
//                Text(Resources.Text.toStartPlay)
//                    .font(.custom(.sfRegular, size: UIScreen.height * 1/48))
//                    .frame(maxWidth: UIScreen.width * 1/3)
//                TextField(Resources.Text.name, text: $appManager.username)
//                    .font(.title)
//                TextField(Resources.Text.email, text: $appManager.email)
//                    .font(.title)
//                SecureField(Resources.Text.password, text: $appManager.password)
//                    .font(.title)
//                CustomButton(action: {
//                    Task {
//                        do {
//                            try await  appManager.testNewUser()
//                        } catch let err {
//                            // Обработка ошибки
//                            print("Ошибка при выполнении test(): (error) - \(err)")
//                        }
//                    }
//                }, title: Resources.Text.signUp, buttonType: .onboarding)
//                Button(action: {dismiss()}) {
//                    Text(Resources.Text.orSignIn)
//                        .foregroundStyle(.white)
//                }
//                Spacer()
//            }
//            .padding()
//        }
//    }
//}
//
////MARK: - PREVIEW
//struct SignUpView_Previews: PreviewProvider {
//    static let previewAppManager = ViewModel()
//    static var previews: some View {
//        SignUpView(appManager: ViewModel())
//    }
//}

