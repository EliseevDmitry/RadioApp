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
    @State var avatar: UIImage?
    
    @State private var isImagePicker = false
    
    private struct Drawing {
        static let avatarSize: CGFloat = 100
        static let editIconSize: CGFloat = 32
        static let spacing: CGFloat = 16
        static let topPadding: CGFloat = 50
        static let fieldTopPadding: CGFloat = 40
        static let iconOffset: CGFloat = 35
        static let textFontSize: CGFloat = 14
    }
    
    var body: some View {
        VStack {
            ZStack {
                DS.Colors.darkBlue
                    .ignoresSafeArea()
                    
                    VStack(spacing: Drawing.spacing) {
                        // MARK: - Profile Image Section
                        Button {
                            isImagePicker.toggle()
                        } label: {
                            ZStack {
                                image(avatar)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width: Drawing.avatarSize, height: Drawing.avatarSize)
                                Image(Resources.Image.editProfileAvatar)
                                    .offset(x: Drawing.iconOffset, y: Drawing.iconOffset)
                                    .frame(width: Drawing.editIconSize, height: Drawing.editIconSize)
                            }
                        }
                        
                        // MARK: - User Info Section
                        Text(userName)
                            .foregroundStyle(.white)
                            .font(
                                .custom(
                                    .sfSemibold, size: Drawing.textFontSize
                                )
                            )
                        
                        Text(verbatim: userEmail)
                            .foregroundStyle(.gray)
                            .font(
                                .custom(
                                    .sfSemibold,
                                    size: Drawing.textFontSize
                                )
                            )
                            .padding(.top, -8)
                        
                        // MARK: - Editable Fields Section
                        CustomTextField(
                            value: $userName,
                            placeHolder: Resources.Text.enterName,
                            titleBorder: Resources.Text.fullName
                        )
                        .padding(.top, Drawing.fieldTopPadding)
                        
                        CustomTextField(
                            value: $userEmail,
                            placeHolder: Resources.Text.enterEmail,
                            titleBorder: Resources.Text.email
                        )
                        .padding(.top, Drawing.fieldTopPadding)
                        
                        CustomButton(action: {}, title: Resources.Text.saveChanges, buttonType: .profile
                        )
                        .padding(.top, Drawing.fieldTopPadding)
                        Spacer()
                    }
                    .padding(.top, Drawing.topPadding)
                    .padding(Drawing.spacing)
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
    
    // MARK: - Helper Functions
    func image(_ image: UIImage?) -> Image {
        if let profileImage = image {
            return Image(uiImage: profileImage)
        } else {
            return Image(uiImage: UIImage(named: "stephen")!)
        }
    }
}

// MARK: - Preview
struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(
            userName: "Stephen",
            userEmail: "stephen@ds",
            avatar: UIImage(named: "stephen")!
        )
    }
}
