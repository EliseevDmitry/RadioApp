//
//  ForgotPassOneView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 04.08.2024.
//

import SwiftUI

struct ForgotPassOneView: View {
    @EnvironmentObject var appManager: HomeViewModel
    // свойство, обеспечивающее работу кнопки "стрелка назад", возвращающей на предыдущий экран
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            AuthBackgroundView()
            
            VStack(alignment: .leading) {
                Spacer()
                
                BackBarButton()
                
                Text(Resources.Text.ForgotPassOne.title)
                    .font(.custom(.sfBold, size: UIScreen.height * 1/16))
                    .padding(.bottom, UIScreen.height * 1/32)
                
                TextField(Resources.Text.ForgotPassOne.email, text: $appManager.email)
                    .font(.title)
                                
                CustomButton(action: {}, title: Resources.Text.ForgotPassOne.sent, buttonType: .onboarding)
                // TODO: изменить тип кнопки и добавить действие
                
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
                    BackBarButton()
//                    Image(systemName: "arrow.left")
                        .foregroundStyle(.primary)
                }
            }
        }
    }
}

struct ForgotPassOneView_Previews: PreviewProvider {
    static let previewAppManager = HomeViewModel()
    
    static var previews: some View {
        ForgotPassOneView()
            .environmentObject(previewAppManager)
    }
}
