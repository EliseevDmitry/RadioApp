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
 
    
    @StateObject var viewModel: ProfileViewModel
    
    @State private var imageURL: URL? = nil
    
    init(
        authService: AuthService = .shared,
        firebaseService: FirebaseStorageService = .shared,
        notificationsService: NotificationsService = .shared
    ) {
        self._viewModel = StateObject(
            wrappedValue: ProfileViewModel(
                authService: authService,
                firebaseStorage: firebaseService,
                notificationsService: notificationsService
            )
        )
    }
    // MARK: - Body
    var body: some View {
        
        ZStack {
            AnimatedBackgroundView()
                .ignoresSafeArea()
            
            VStack {
                // MARK: - Profile Info
                ProfileInfoView(
                    userName: viewModel.userName,
                    userEmail: viewModel.userEmail,
                    profileImage: UIImage(systemName: "person.fill")!
                )
                // MARK: - General Settings
                SettingView(
                    generalTitle: Resources.Text.general.localized(language),
                    firstTitle: Resources.Text.notification.localized(language),
                    firstImageIcon: Resources.Image.notification,
                    settingsRoute: { NotificationsView(notificationAction: notificationAction) },
                    secondTitle: Resources.Text.language.localized(language),
                    secondImageIcon: Resources.Image.globe.localized(language),
                    secondSettingsRoute: { LanguageView() }
                )
                
                // MARK: - More Settings
                SettingView(
                    generalTitle: Resources.Text.more.localized(language),
                    firstTitle: Resources.Text.legalAndPolicies.localized(language),
                    firstImageIcon: Resources.Image.shield,
                    settingsRoute: { LegalPoliciesView() },
                    secondTitle: Resources.Text.aboutUs.localized(language),
                    secondImageIcon: Resources.Image.information,
                    secondSettingsRoute: { AboutUs() }
                )
                Spacer()
                // MARK: - Logout Button
                CustomButton(
                    action: { viewModel.showLogoutAlert() },
                    title: Resources.Text.logOut.localized(language),
                    buttonType: .profile)
            }
            .padding()
            .foregroundColor(.white)
            
            .navigationTitle(Resources.Text.settings.localized(language))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackBarButton()
                }
            }
            
            .alert(isPresented: isPresentedAlert(),
                   error: viewModel.error) {
                Button("Ok", action:
                        viewModel.tapErrorOk)
                Button("Cancel", action:
                        viewModel.cancelErrorAlert)
            }
        }
    }
    
    //    MARK: - Private Methods
    
    private func notificationAction() {
        //        viewModel.configureNotifications()
    }
    
    private func isPresentedAlert() -> Binding<Bool> {
        Binding(get: { viewModel.error != nil },
                set: { isPresenting in
            if isPresenting { return }
            viewModel.error = nil
        }
        )
    }
}


// MARK: - Preview
#Preview {
    ProfileView()
}
