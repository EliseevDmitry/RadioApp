//
//  ForgotPassTwoView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 04.08.2024.
//

import SwiftUI

struct ForgotPassTwoView: View {
    //MARK: - PROPERTIES
    @ObservedObject var appManager: ViewModel
    //MARK: - BODY
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            AuthBackgroundView()
            VStack(alignment: .leading) {
                Spacer()
                BackBarButton()
                Text(Resources.Text.forgotPassword)
                    .font(.custom(.sfBold, size: UIScreen.height * 1/16))
                    .padding(.bottom, UIScreen.height * 1/32)
                SecureField(Resources.Text.forgotPassword, text: $appManager.password) //$appManager.password
                    .font(.title)
                SecureField(Resources.Text.confirmPassword, text: $appManager.password) //$appManager.password
                    .font(.title)
                CustomButton(action: {}, title: Resources.Text.changePassword, buttonType: .onboarding) // TODO: изменить тип кнопки и добавить действие
                Spacer()
            }
            .padding()
        }
    }
}

//MARK: - PREVIEW
struct ForgotPassTwoView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    static var previews: some View {
        ForgotPassTwoView(appManager: previewAppManager)
    }
}
