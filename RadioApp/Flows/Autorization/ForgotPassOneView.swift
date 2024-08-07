//
//  ForgotPassOneView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 04.08.2024.
//

import SwiftUI

struct ForgotPassOneView: View {
    @EnvironmentObject var appManager: ViewModel
    // свойство, обеспечивающее работу кнопки "стрелка назад", возвращающей на предыдущий экран
    @Environment(\.dismiss) var dismiss
    
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
                
                TextField(Resources.Text.email, text: $appManager.email)
                    .font(.title)
                
                CustomButton(action: {
                    NavigationLink(
                        destination: ForgotPassTwoView()
                            .navigationBarBackButtonHidden()
                            .environmentObject(appManager)
                    ) {
                        Text(Resources.Text.forgotPassword)
                            .foregroundStyle(.white)
                    }
                }, title: Resources.Text.sent, buttonType: .onboarding) // TODO: изменить тип кнопки и добавить действие
                
                Spacer()
            }
            .padding()
        }
        // в панели навигации: стрелка влево вместо кнопки Back
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    //                    BackBarButton()
                    Image(systemName: Resources.Image.arrowLeft)
                        .foregroundStyle(.primary)
                }
            }
            /*
             ToolbarItem(placement: .topBarTrailing) {
             Text(Resources.Text.settings)
             .offset(-UIScreen.width / 2)
             }
             */
        }
        
        
    }
}

struct ForgotPassOneView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        ForgotPassOneView()
            .environmentObject(previewAppManager)
    }
}
