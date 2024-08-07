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
    @AppStorage("selectedLanguage") private var language = LocalizationService.shared.language
    
    @ObservedObject var viewModel: ProfileViewModel
    
    @State private var showLogoutAlert: Bool = false
    @State private var errorAlert: AnyAppAlert? = nil
    
    @State private var imageURL: URL? = nil
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                AnimatedBackgroundView()
                    .ignoresSafeArea()
                
                VStack {
                    // MARK: - Profile Info
                    ProfileInfoView(
                        userName: viewModel.currentUser?.userName ?? "",
                        userEmail: viewModel.currentUser?.email ??  "",
                        profileImage: UIImage(systemName: "person.fill")!,
                        saveChangesAction: saveChanges
                    )
                    // MARK: - General Settings
                    SettingView(
                        generalTitle: Resources.Text.general.localized(language),
                        firstTitle: Resources.Text.notification.localized(language),
                        firstImageIcon: Resources.Image.notification,
                        firstDestination: AnyView(NotificationView(notificationAction: notificationAction)),
                        secondTitle: Resources.Text.language.localized(language),
                        secondImageIcon: Resources.Image.globe.localized(language),
                        secondDestination: AnyView(LanguageView())
                    )
                    
                    // MARK: - More Settings
                    SettingView(
                        generalTitle: Resources.Text.more.localized(language),
                        firstTitle: Resources.Text.legalAndPolicies.localized(language),
                        firstImageIcon: Resources.Image.shield,
                        firstDestination: AnyView(LegalPoliciesView()),
                        secondTitle: Resources.Text.aboutUs.localized(language),
                        secondImageIcon: Resources.Image.information,
                        secondDestination: AnyView(AboutUs())
                    )
                    Spacer()
                    // MARK: - Logout Button
                    CustomButton(
                        action: { showLogoutAlert = true },
                        title: Resources.Text.logOut.localized(language),
                        buttonType: .profile)
                }
                .padding()
                .foregroundColor(.white)
                .showCustomAlert(alert: $errorAlert)
                .navigationTitle(Resources.Text.settings.localized(language))
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text(Resources.Text.logOut.localized(language)),
                        message: Text(Resources.Text.areYouWantLogOut.localized(language)),
                        primaryButton: .destructive(Text(Resources.Text.logOut.localized(language))) {
                            logOut()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
        .onReceive(viewModel.$error) { error in
            if let error = error {
                errorAlert = AnyAppAlert(error: error)
                viewModel.clearError()
            }
        }
    }
    
    //    MARK: - Private Methods
    private func saveChanges(_ userName: String, _ userEmail: String, _ avatar: UIImage?) {
        viewModel.updateUserProfile(
            userName,
            userEmail,
            avatar
        )
    }
    
    private func notificationAction() {
        viewModel.notificationAction()
    }
    
    private func logOut() {
        viewModel.logOut()
        #warning("проверить вариант перехода на Онбординг")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController = UIHostingController(rootView: WelcomeView())
                window.makeKeyAndVisible()
            }
        }
    }
}


// MARK: - Preview
#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
