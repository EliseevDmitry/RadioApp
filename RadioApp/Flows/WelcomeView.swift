//
//  ContentView.swift
//  RadioApp
//
//  Created by Denis Gindulin on 28.07.2024.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var appManager: ViewModel
    
    var body: some View {
        ZStack {
            WelcomeBackgroundView()
            
            VStack(alignment: .leading) {
                Spacer()
                
                VStack(alignment: .leading) {
                    // MARK: - Title Text
                    Text(Resources.Text.letSGetStarted)
                        .font(.custom(.sfBold, size: UIScreen.height * 1/16))
                        .padding(.bottom, UIScreen.height * 1/32)

                    // MARK: - Explanation Text
                    Text(Resources.Text.enjpiTheBestRadio)
                        .font(.custom(.sfRegular, size: UIScreen.height * 1/48))
                        .frame(maxWidth: UIScreen.width * 1/3)
                }
                .foregroundColor(.white)
                
                Spacer()
                Spacer()
                
                // MARK: - GetStarted Button
                CustomButton(
                    action: {},
                    title: Resources.Text.getStarted,
                    buttonType: .onboarding)
            }
            .frame(maxWidth: UIScreen.width * 2/3)
            .padding(.bottom, UIScreen.width * 1/6)
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
