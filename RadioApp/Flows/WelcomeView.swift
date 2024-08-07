//
//  ContentView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 28.07.2024.
//

import SwiftUI

// MARK: - WelcomeView
struct WelcomeView: View {
    // MARK: - Properties
    @EnvironmentObject var appManager: ViewModel
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        // размеры - адаптивные: привязаны к ширине и высоте экрана (UIScreen)
        static let screenTitleFontSize = UIScreen.height * 1/16
        static let screenTitleBottomPadding = UIScreen.height * 1/32
        static let screenSubtitleFontSize = UIScreen.height * 1/48
        static let screenSubtitleFrameWidth = UIScreen.width * 1/3
        static let screenContentFrameWidth = UIScreen.width * 2/3
        static let screenContentBottomPadding = (UIScreen.width - screenContentFrameWidth) / 2
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                WelcomeBackgroundView()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        // MARK: - Title
                        Text(Resources.Text.letsGetStarted)
                            .font(.custom(.sfBold, size: DrawingConstants.screenTitleFontSize))
                            .padding(.bottom, DrawingConstants.screenTitleBottomPadding)

                        // MARK: - Subtitle
                        Text(Resources.Text.enjoyTheBestRadio)
                            .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
                            .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    Spacer()
                    
                    // MARK: GetStarted Button
                    NavigationLink(isActive: $appManager.onboardingIsShown) {
                        SignInView()
                            .navigationBarBackButtonHidden()
                            .environmentObject(appManager)
                    } label: {
                        CustomButton(action: {appManager.onboardingIsShown.toggle()}, title: Resources.Text.getStarted, buttonType: .onboarding)
                    }
                    
                    /*
                    NavigationLink(
                        destination: SignInView()
                            .navigationBarBackButtonHidden()
                            .environmentObject(appManager)
                    ) {
                        Text(Resources.Text.getStarted)
                            .foregroundStyle(.white)
                    }
                    */
                    
                    /*
                    NavigationLink(isActive: $onboardingPage1ViewIsOn) {
                        OnboardingPage1View(appManager: appManager)
                            .navigationBarBackButtonHidden()
                    } label: {
                        StartButtonView(title: "Get Started") {
                            onboardingPage1ViewIsOn.toggle()
                        }
                    }
                    */
                    
                    /*
                    // MARK: GetStarted Button
                    CustomButton(
                        action: {},
                        title: Resources.Text.getStarted,
                        buttonType: .onboarding)
                    */
                }
                .frame(maxWidth: DrawingConstants.screenContentFrameWidth)
                .padding(.bottom, DrawingConstants.screenContentBottomPadding)
            }
        }
    }
}

extension UIScreen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
}

struct WelcomeView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        WelcomeView()
            .environmentObject(previewAppManager)
    }
}
