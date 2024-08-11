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
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        // размеры - адаптивные: привязаны к ширине и высоте экрана (UIScreen)
        static let screenTitleFontSize = UIScreen.height * 1/16
        static let screenContentPadding = UIScreen.width * 1/16
        static let verticalPaddingSize = UIScreen.height * 1/54
        static let screenTitleFrameWidth = UIScreen.width * 2/3
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: Background
            background
            
            VStack(alignment: .leading) {
                Spacer()
                
                // MARK: Screen Content
                backButton
                
                titleText
                
                inputFields
                
                changePasswordButton
                
                Spacer()
            }
            .padding(32)
        }
    }
    
    // MARK: - Subviews
    private var background: some View {
        ZStack {
            AnimatedBackgroundView(screenType: .authentication)
            AuthBackgroundView()
        }
    }
    
    private var backButton: some View {
        BackBarButton()
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding(.bottom, 30)
    }
    
    private var titleText: some View {
        HStack {
            Text(Resources.Text.forgotPassword)
                .font(.custom(.sfBold, size: DrawingConstants.screenTitleFontSize))
                .foregroundColor(.white)
            Spacer()
        }.frame(maxWidth: DrawingConstants.screenTitleFrameWidth)
    }
    
    private var inputFields: some View {
        VStack {
            FieldForPasswordView()
            FieldForConfirmPasswordView()
        }
        .padding(.vertical, DrawingConstants.verticalPaddingSize)
    }
    
    private var changePasswordButton: some View {
        CustomButton(action: {
            appManager.password == appManager.confirmPassword ? appManager.registerUser() : print("Passwords do not match (введенные пароли не совпадают)")
        }, title: Resources.Text.changePassword, buttonType: .authentication)
    }
}

struct ForgotPassTwoView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        ForgotPassTwoView()
            .environmentObject(previewAppManager)
    }
}



/*
// свойство, обеспечивающее работу кнопки "стрелка назад", возвращающей на предыдущий экран
@Environment(\.dismiss) var dismiss
*/

/*
 AnimatedBackgroundView(screenType: .authentication)
 AuthBackgroundView()
 */


/*
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
 
 */

/*
 // MARK: ChangePassword Button
 // при нажатии на кнопку происходит сравнение введенных паролей и при совпадении происходит регистрация в базе данных нового пользователя, при несовпадении - сообщение в консоль
 CustomButton(action: {
 appManager.password == appManager.confirmPassword ? appManager.registerUser() : print("Passwords do not match (введенные пароли не совпадают)")
 }, title: Resources.Text.changePassword, buttonType: .authentication)
 */



/*
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
 */
