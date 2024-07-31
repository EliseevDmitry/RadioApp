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
            VStack {
                // MARK: - Profile Info
                ProfileInfoView(
                    userName: "Stephen",
                    email: "stephen@ds",
                    avatar: UIImage(named: "stephen")!, 
                    editAction: {}
                )
                
                // MARK: - General Settings
                SettingView(
                    generalTitle: Resources.Text.general,
                    destinationTitleFirst: Resources.Text.notification,
                    destinationFirst: LegalPoliciesView(),
                    imageIconFirst: Resources.Image.notification,
                    destinationTitleSecond: Resources.Text.language,
                    destinationSecond: LegalPoliciesView(),
                    imageIconSecond: Resources.Image.globe
                )
                
                // MARK: - More Settings
                SettingView(
                    generalTitle: Resources.Text.more,
                    destinationTitleFirst: Resources.Text.legalAndPolicies,
                    destinationFirst: LegalPoliciesView(),
                    imageIconFirst: Resources.Image.shield,
                    destinationTitleSecond: Resources.Text.aboutUs,
                    destinationSecond: LegalPoliciesView(),
                    imageIconSecond: Resources.Image.information
                )
                
                // MARK: - Logout Button
                CustomButton(
                    action: {},
                    title: Resources.Text.logOut,
                    buttonType: .profile)
            }
            .padding()
            .background(DS.Colors.darkBlue.ignoresSafeArea())
            .navigationTitle(Resources.Text.settings)
            .foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
