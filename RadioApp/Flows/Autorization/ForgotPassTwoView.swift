//
//  ForgotPassTwoView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 04.08.2024.
//

import SwiftUI

struct ForgotPassTwoView: View {
    @EnvironmentObject var appManager: ViewModel
    
    private struct DrawingConstants {
        // размеры - адаптивные: привязаны к ширине и высоте экрана (UIScreen)
        static let screenTitleFontSize = UIScreen.height * 1/16
        static let screenTitleBottomPadding = UIScreen.height * 1/32
    }
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView(screenType: .authentication)
            AuthBackgroundView()
            
            VStack(alignment: .leading) {
                Spacer()
                
                BackBarButton()
                
                Text(Resources.Text.forgotPassword)
                    .font(.custom(.sfBold, size: DrawingConstants.screenTitleFontSize))
                    .padding(.bottom, DrawingConstants.screenTitleBottomPadding)
                
                SecureField(Resources.Text.password, text: $appManager.password)
                    .font(.title)
                
                SecureField(Resources.Text.confirmPassword, text: $appManager.confirmPassword)
                    .font(.title)
                                
                // при нажатии на кнопку происходит сравнение введенных паролей и при совпадении происходит регистрация в базе данных нового пользователя, при несовпадении - сообщение в консоль
                CustomButton(action: {
                    appManager.password == appManager.confirmPassword ? appManager.registerUser() : print("Passwords do not match (введенные пароли не совпадают)")
                }, title: Resources.Text.changePassword, buttonType: .onboarding) // TODO: изменить тип кнопки и добавить действие
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ForgotPassTwoView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        ForgotPassTwoView()
            .environmentObject(previewAppManager)
    }
}
