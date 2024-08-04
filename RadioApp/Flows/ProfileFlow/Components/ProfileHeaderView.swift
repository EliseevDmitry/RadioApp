//
//  ProfileHeaderView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 02.08.2024.
//

import SwiftUI

struct ProfileHeaderView: View {
    @Binding var userName: String
    @Binding var userEmail: String
    @Binding var avatar: UIImage?
    @Binding var showChangedPhotoView: Bool
    
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
            Button {
                showChangedPhotoView.toggle()
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
                .font(.custom(.sfSemibold, size: Drawing.textFontSize))
            
            Text(verbatim: userEmail)
                .foregroundStyle(.gray)
                .font(.custom(.sfSemibold, size: Drawing.textFontSize))
                .padding(.top, -8)
        }
        .padding()
//        .onTapGesture {
//            withAnimation {
//                showChangedPhotoView.toggle()
//            }
//        }
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



#Preview {
    ProfileHeaderView(
        userName: .constant("Stephen"),
        userEmail: .constant("stephen@ds"),
        avatar: .constant(UIImage(named: "stephen")!),
        showChangedPhotoView: .constant(false)
    )
}

