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
    @State private var alert: AnyAppAlert?
    @State private var errorAlert: AnyAppAlert? = nil
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let screenLogoImageWidth = UIScreen.width * 1/6
        static let screenLogoImageHeight = screenLogoImageWidth
        static let screenTitleFontSize = UIScreen.height * 1/16
        static let screenTitleBottomPadding = UIScreen.height * 1/32
        static let screenSubtitleFontSize = UIScreen.height * 1/48
        static let screenSubtitleFrameWidth = UIScreen.width * 1/3
        static let screenContentPadding = UIScreen.width * 1/16
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
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
                    Text(Resources.Text.signIn)
                        .font(.custom(.sfBold, size: DrawingConstants.screenTitleFontSize))
                        .padding(.bottom, DrawingConstants.screenTitleBottomPadding)
                        .foregroundStyle(.white)
                        .showCustomAlert(alert: $alert)
                        .showCustomAlert(alert: $alert)
                        .background(
                            NavigationLink(destination: ContentView(), isActive: $isAuthenticated) { EmptyView() }
                        )

                    
                    // MARK: Subtitle
                    Text(Resources.Text.toStartPlay)
                        .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
                        .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
                        .foregroundStyle(.white)
                    
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
                    
                    
                    
                    
                    /*
                     NavigationLink(destination: ForgotPassOneView().environmentObject(appManager)) {
                     Text(Resources.Text.forgotPassword)
                     .foregroundStyle(.white)
                     }
                     */
                    
                    // MARK: ForgotPassword Button
                    NavigationLink(
                        destination: ForgotPassOneView()
                            .navigationBarBackButtonHidden()
                            .environmentObject(appManager)
                    ) {
                        Text("\(Resources.Text.forgotPassword)?")
                            .foregroundStyle(.white)
                    }
                    
                    // MARK: Google Button
                    HStack {
                        Rectangle()
                            .frame(width: 50, height: 1)
                        Text(Resources.Text.orConnectWith)
                        Rectangle()
                            .frame(width: 50, height: 1)
                    }
                    .foregroundStyle(.gray)
                    
                    Button(action: appManager.signInWithGoogle) {
                        Text("G+")
                            .foregroundStyle(.white)
                    }
                    
                    // MARK: SignIn Button
                    CustomButton(
                        action: { appManager.signIn() },
                        title: Resources.Text.signIn,
                        buttonType: .authentication
                    )
                    
                    /*
                     CustomButton(
                     action: {
                     Task {
                     do {
                     try appManager.logOut()
                     appManager.showSignInView = true
                     } catch {
                     print(error)
                     }
                     }
                     },
                     title: Resources.Text.logOut,
                     buttonType: .profile
                     )
                     */
                    
                    /*
                     // версия 08.08.2024.14:32
                     NavigationLink(isActive: $appManager.isSignedIn) {
                     PopularView()
                     .navigationBarBackButtonHidden()
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
                     */
                    
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
                .padding(DrawingConstants.screenContentPadding)
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func signIn() async {
        await appManager.signIn()
        if appManager.error != nil {
            alert = AnyAppAlert(error: appManager.error!)
            showAlert = true
        } else {
            isAuthenticated = true
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

/*

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
 
 CustomButton(action: {
     Task {
         await signIn()
     }
 },
              title: Resources.Text.SignIn.title,
              buttonType: .onboarding
 )
 // TODO: добавить в типы кнопок третий тип - для этой группы экранов и при выборе типа заменить тернарный оператор на switch (обсудить с Димой Келлером)
 
 Button(action: {
 */





/*
 /*
  CustomButton(action: {
  appManager.signIn()
  appManager.updateContext()
  },
  title: Resources.Text.signIn,
  buttonType: .authentication
  )
  // TODO: добавить в типы кнопок третий тип - для этой группы экранов и при выборе типа заменить тернарный оператор на switch (обсудить с Димой Келлером)
  
  Button(action: {
  
  }) {
  Text(Resources.Text.orSignUp)
  */
 */



/*
 }) {
     Text(Resources.Text.SignIn.orSignUp)
 */
