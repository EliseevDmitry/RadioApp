//
//  ProfileEditView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct ProfileEditView: View {
    
    @State var userName: String
    @State var userEmail: String
    
    var body: some View {
        VStack {
            ZStack {
                DS.Colors.darkBlue
                    .ignoresSafeArea()
            
            VStack {
                
                Text(userName)
                    .foregroundStyle(.white)
                    .font(
                        .custom(
                            .sfSemibold, size: 14
                        )
                    )
                
                Text(verbatim: userEmail)
                    .foregroundStyle(.gray)
                    .font(
                        .custom(
                            .sfSemibold,
                            size: 14
                        )
                    )
                    .padding(.top, -8)
                
                CustomTextField(
                    value: $userName, 
                    placeHolder: Resources.Text.enterName,
                    titleBorder: Resources.Text.fullName
                )
                .padding(.top, 40)
                
                CustomTextField(
                    value: $userEmail,
                    placeHolder: Resources.Text.enterEmail,
                    titleBorder: Resources.Text.email
                )
                .padding(.top, 40)
                CustomButton(action: {}, title: Resources.Text.saveChanges, buttonType: .profile
                )
                .padding(.top, 40)
               Spacer()
            }
            .padding(.top, 50)
            .navigationTitle(Resources.Text.profile.capitalized)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackBarButton()
                }
                }
            }
        }
    }
}

#Preview {
    ProfileEditView(userName: "Steven", userEmail: "Steven@d.com")
}
