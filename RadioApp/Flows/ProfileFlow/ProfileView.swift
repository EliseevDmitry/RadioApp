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
    
    /*
    // это свойство позволяет обращаться к единой вью-модели приложения, например, чтобы разлогиниться тому пользователю, который залогинился на экране SignView
    @EnvironmentObject var appManager: ViewModel
    */
    

    @State private var errorAlert: AnyAppAlert? = nil
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                AnimatedBackgroundView(screenType: .profile)
                    .ignoresSafeArea()
                
                VStack {
                    // MARK: - Profile Info
                    ProfileInfoView(
                        userName: viewModel.currentUser?.userName ?? "Stephen",
                        userEmail: viewModel.currentUser?.email ??  "stephen@ds",
                        avatar: loadImage(from: viewModel.currentUser?.avatarURL),
                        saveChangesAction: saveChanges
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
                        action: logOut,
                        title: Resources.Text.logOut,
                        buttonType: .profile)
                    
                    /*
                    // это вариант кнопки Log Out, действие по нажатию на которую происходит через обращение к единой вью-модели приложения
                    CustomButton(
                        action: {
                            Task {
                                do {
                                    try appManager.logOut()
                                    appManager.showSignInView = true
                                } catch {
                                    print(error)
                                }
                            }
                        },
                        title: Resources.Text.logOut,
                        buttonType: .profile
                    )
                    */
                    
                }
                .padding()
                .foregroundColor(.white)
                .showCustomAlert(alert: $errorAlert)
                .navigationTitle(Resources.Text.settings)
                .navigationBarTitleDisplayMode(.inline)
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
    
    private func logOut() {
        viewModel.logOut()
    }
    
    private func loadImage(from urlString: String?) -> UIImage {
        guard let urlString = urlString, !urlString.isEmpty,
              let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return UIImage(named: "stephen") ?? UIImage()
        }
        return image
    }
}


// MARK: - Preview
#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
