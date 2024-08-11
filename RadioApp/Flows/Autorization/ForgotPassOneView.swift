//
//  ForgotPassOneView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 04.08.2024.
//

import SwiftUI

// MARK: - ForgotPassword First View
struct ForgotPassOneView: View {
    // MARK: - Properties
    @EnvironmentObject var appManager: ViewModel
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let screenTitleFontSize = UIScreen.height * 1/24
        static let screenTitleFrameWidth = UIScreen.width * 2/3
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
                backButton
                
                titleText
                
                inputFields
                
                sentButton

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
                .font(.custom(.sfBold, size:
                                DrawingConstants.screenTitleFontSize))
                .foregroundColor(.white)
            Spacer()
        }.frame(maxWidth: DrawingConstants.screenTitleFrameWidth)
    }
    
    private var inputFields: some View {
        VStack {
            TextFieldForEmailView()
        }
        .padding(.vertical, DrawingConstants.verticalPaddingSize * 4)
    }
    
    private var sentButton: some View {
        CustomButton(action: {
            NavigationLink(destination: ForgotPassTwoView().navigationBarBackButtonHidden()) {
                Text(Resources.Text.forgotPassword)
                    .foregroundStyle(.white)
            }
        }, title: Resources.Text.sent, buttonType: .authentication)
    }
}

struct ForgotPassOneView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        ForgotPassOneView()
            .environmentObject(previewAppManager)
    }
}



/*

// свойство, обеспечивающее работу кнопки "стрелка назад", возвращающей на предыдущий экран
@Environment(\.dismiss) var dismiss
*/

/*
 // MARK: Back Button
 BackBarButton()
 */

/*
 // MARK: Title
 Text(Resources.Text.forgotPassword)
 .font(.custom(.sfBold, size: DrawingConstants.screenTitleFontSize))
 .padding(.bottom, DrawingConstants.screenTitleBottomPadding)
 .foregroundStyle(.white)
 
 // MARK: Email Textfield
 Text(Resources.Text.email)
 .font(.custom(.sfRegular, size: DrawingConstants.screenSubtitleFontSize))
 .frame(maxWidth: DrawingConstants.screenSubtitleFrameWidth)
 .foregroundStyle(.white)
 
 TextField(Resources.Text.yourEmail, text: $appManager.email)
 .font(.title)
 .background(.white)
 */

/*
 CustomTextField(value: $appManager.email, placeHolder: Resources.Text.yourEmail, titleBorder: Resources.Text.email)
 */

/*
 // MARK: ForgotPassword Button
 NavigationLink(
 destination: ForgotPassTwoView()
 .navigationBarBackButtonHidden()
 .environmentObject(appManager)
 ) {
 Text("\(Resources.Text.forgotPassword)?")
 .foregroundStyle(.white)
 }
 */

// MARK: Sent Button
/*
 CustomButton(action: {
 NavigationLink(
 destination: ForgotPassTwoView()
 .navigationBarBackButtonHidden()
 //.environmentObject(appManager)
 ) {
 Text(Resources.Text.forgotPassword)
 .foregroundStyle(.white)
 }
 }, title: Resources.Text.sent, buttonType: .authentication)
 
 Spacer()
 }
 .padding(DrawingConstants.screenContentPadding)
 }
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
