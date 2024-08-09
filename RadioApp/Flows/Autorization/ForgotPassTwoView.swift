//
//  ForgotPassTwoView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 04.08.2024.
//

import SwiftUI

// MARK: - ForgotPassword Second View
struct ForgotPassTwoView: View {
    // MARK: - Properties
    @EnvironmentObject var appManager: ViewModel
    // свойство, обеспечивающее работу кнопки "стрелка назад", возвращающей на предыдущий экран
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        // размеры - адаптивные: привязаны к ширине и высоте экрана (UIScreen)
        static let screenTitleFontSize = UIScreen.height * 1/16
        static let screenTitleBottomPadding = UIScreen.height * 1/32
        static let screenSubtitleFontSize = UIScreen.height * 1/48
        static let screenSubtitleFrameWidth = UIScreen.width * 2/3
        static let screenSubtitleBottomPadding = UIScreen.height * 1/16
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
                    
                    // MARK: Back Button
                    BackBarButton()
                        .foregroundColor(.white)
                    
                    // MARK: Title
                    Text(Resources.Text.forgotPassword)
                        .font(.custom(.sfBold, size: DrawingConstants.screenTitleFontSize))
                        .padding(.bottom, DrawingConstants.screenTitleBottomPadding)
                        .foregroundStyle(.white)
                    
                    // MARK: Password Securefield
                    Text(Resources.Text.password)
                        .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
                        .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
                        .foregroundStyle(.white)
                    
                    SecureField(Resources.Text.yourPassword, text: $appManager.password)
                        .font(.title)
                        .background(.white)
                    
                    // MARK: ConfirmPassword Securefield
                    Text(Resources.Text.confirmPassword)
                        .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
                        .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
                        .foregroundStyle(.white)
                    
                    SecureField(Resources.Text.yourPassword, text: $appManager.confirmPassword)
                        .font(.title)
                        .background(.white)
                    
                    // MARK: ChangePassword Button
                    // при нажатии на кнопку происходит сравнение введенных паролей и при совпадении происходит регистрация в базе данных нового пользователя, при несовпадении - сообщение в консоль
                    CustomButton(action: {
                        appManager.password == appManager.confirmPassword ? appManager.registerUser() : print("Passwords do not match (введенные пароли не совпадают)")
                    }, title: Resources.Text.changePassword, buttonType: .authentication)
                    
                    Spacer()
                }
                .padding(DrawingConstants.screenContentPadding)
            }
            // MARK: Back Button
            // в панели навигации: стрелка влево вместо кнопки Back
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: Resources.Image.arrowLeft)
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ForgotPassTwoView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        ForgotPassTwoView()
            .environmentObject(previewAppManager)
    }
}
