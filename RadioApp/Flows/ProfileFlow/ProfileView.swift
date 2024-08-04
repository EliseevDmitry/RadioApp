//
//  ProfileView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

// MARK: - ProfileView
struct ProfileView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: ProfileViewModel
    @State private var inputImage = UIImage(named: Resources.Image.stephen)
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                AnimatedBackgroundView()
                    .ignoresSafeArea()
                
                VStack {
                    // MARK: - Profile Info
                    ProfileInfoView(
                        userName: viewModel.currentUser?.userName ?? "Stephen",
                        userEmail: viewModel.currentUser?.email ??  "stephen@ds",
                        avatar: inputImage ?? UIImage(systemName: "person.fill")!
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
                    Spacer()
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
    ProfileView(viewModel: ProfileViewModel())
}
