//
//  ProfileEditView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct ProfileEditView: View {
    
    @State var name: String
    
    var body: some View {
        VStack {
            ZStack {
                DS.Colors.darkBlue
                    .ignoresSafeArea()
            
            VStack {
                
                ProfileTextField(
                    value: $name, placeHolder: Resources.Text.enterName, titleBorder: Resources.Text.fullName)
                
                CustomButton(action: {}, title: Resources.Text.saveChanges, buttonType: .profile
                )
//                Spacer()
            }
            
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
    ProfileEditView(name: "Steven")
}
