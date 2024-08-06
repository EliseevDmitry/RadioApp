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
    
    @State private var showChangedView = false
    @State private var blurBackground  = false
    @State private var isImagePickerPresented  = false
    @State private var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    
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
        ZStack {
            VStack {
                ZStack {
                    AnimatedBackgroundView(screenType: .profile)
                        .ignoresSafeArea()
                    
                    VStack(spacing: Drawing.spacing) {
                        // MARK: - Profile Image Section
                        ProfileHeaderView(
                            userName: $userName,
                            userEmail: $userEmail,
                            avatar: $avatar,
                            showChangedPhotoView: $showChangedView
                        )
                        
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
                        
                        Spacer()
                        
                        CustomButton(action: {}, title: Resources.Text.saveChanges, buttonType: .profile
                        )
                        
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
            .blur(radius: showChangedView ? 10 : 0)
            
            if showChangedView {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            hideChangedPhotoView()
                        }
                    }
                
                ChangePhotoView(
                    onTakePhoto: {
                        showImagePicker(source: .camera)
                    },
                    onChoosePhoto: {
                        showImagePicker(source: .photoLibrary)
                    },
                    onDeletePhoto: {
                        avatar = UIImage(named: "NoPhoto")
                        hideChangedPhotoView()
                    }
                )
                .frame(width: 300, height: 200)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
                   ImagePicker(sourceType: imagePickerSource) { image in
                       avatar = image
                   }
        }
    }
    
    // MARK: - Helper Functions
    func showChangedPhotoView() {
        blurBackground = true
        showChangedView = true
    }
    
    func hideChangedPhotoView() {
        blurBackground = false
        showChangedView = false
    }
    
    func showImagePicker(source: UIImagePickerController.SourceType) {
        imagePickerSource = source
        isImagePickerPresented = true
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
