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
    // свойство, обеспечивающее работу кнопки "стрелка назад", возвращающей на предыдущий экран
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let screenTitleFontSize = UIScreen.height * 1/16
        static let screenTitleBottomPadding = UIScreen.height * 1/32
        static let screenSubtitleFontSize = UIScreen.height * 1/48
        static let screenSubtitleFrameWidth = UIScreen.width * 1/3
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
                    
                    /*
                     // MARK: Back Button
                     BackBarButton()
                     */
                    
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

struct ForgotPassOneView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        ForgotPassOneView()
            .environmentObject(previewAppManager)
    }
}
