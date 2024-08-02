//
//  ProfileView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

// MARK: - ProfileView
struct ProfileView: View {
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                DS.Colors.darkBlue
                    .ignoresSafeArea()
                
                VStack {
                    // MARK: - Profile Info
                    ProfileInfoView(
                        userName: "Stephen",
                        email: "stephen@ds",
                        avatar: UIImage(named: "stephen")!,
                        editAction: {
                            // Navigation to ProfileEditView
                        }
                    )
                    
                    // MARK: - General Settings
                    SettingView(
                        generalTitle: Resources.Text.general,
                        firstTitle: Resources.Text.notification,
                        firstImageIcon: Resources.Image.notification,
                        firstDestination: AnyView(LegalPoliciesView()),
                        secondTitle: Resources.Text.language,
                        secondImageIcon: Resources.Image.globe,
                        secondDestination: AnyView(LanguageView())
                    )
                    
                    // MARK: - More Settings
                    SettingView(
                        generalTitle: Resources.Text.more,
                        firstTitle: Resources.Text.legalAndPolicies,
                        firstImageIcon: Resources.Image.shield,
                        firstDestination: AnyView(LegalPoliciesView()),
                        secondTitle: Resources.Text.aboutUs,
                        secondImageIcon: Resources.Image.information,
                        secondDestination: AnyView(AboutUs())
                    )
                    
                    // MARK: - Logout Button
                    CustomButton(
                        action: {},
                        title: Resources.Text.logOut,
                        buttonType: .profile)
                }
                .padding()
                .foregroundColor(.white)
                .navigationTitle(Resources.Text.settings)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ProfileView()
}
