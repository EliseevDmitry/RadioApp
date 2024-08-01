//
//  ProfileEditView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct ProfileEditView: View {
    var body: some View {
        VStack {
            ZStack {
                DS.Colors.darkBlue
                    .ignoresSafeArea()
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

#Preview {
    ProfileEditView()
}
