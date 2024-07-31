//
//  ProfileInfoView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 30.07.2024.
//

import SwiftUI

import SwiftUI

// MARK: - ProfileInfoView
struct ProfileInfoView: View {
    // MARK: - Properties
    var userName: String
    var email: String
    var avatar: UIImage
    var editAction: () -> Void
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let avatarSize: CGFloat = 54
        static let avatarLeadingPadding: CGFloat = 16
        static let textSpacing: CGFloat = 8
        static let textLeadingPadding: CGFloat = 8
        static let cornerRadius: CGFloat = 16
        static let strokeWidth: CGFloat = 1.0
        static let strokeOpacity: CGFloat = 0.2
        static let buttonSize: CGFloat = 24
        static let buttonPadding: CGFloat = 16
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(uiImage: avatar)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(
                    width: DrawingConstants.avatarSize,
                    height: DrawingConstants.avatarSize
                )
                .padding(.leading, DrawingConstants.avatarLeadingPadding)
            
            VStack(
                alignment: .leading,
                spacing: DrawingConstants.textSpacing
            ) {
                Text(userName)
                    .font(Font.custom(.sfMedium, size: 16))
                    .foregroundColor(.white)
                
                Text(email)
                    .font(Font.custom(.sfMedium, size: 14))
                    .foregroundColor(Color.gray)
            }
            
            .padding(.leading, DrawingConstants.textLeadingPadding)
            
            Spacer()
            // MARK: - Edit Button
                       Button(action: editAction) {
                           Image(Resources.Image.edit)
                               .resizable()
                               .frame(
                                   width: DrawingConstants.buttonSize,
                                   height: DrawingConstants.buttonSize
                               )
                               .padding(.trailing, DrawingConstants.buttonPadding)
                       
                   }
        }
        
        .padding()
        .background(DS.Colors.darkBlue)
        .cornerRadius(DrawingConstants.cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                .stroke(
                    Color.gray,
                    lineWidth: DrawingConstants.strokeWidth
                )
                .opacity(DrawingConstants.strokeOpacity)
        }
    }
}

// MARK: - Preview
#Preview {
    ProfileInfoView(
        userName: "Stephen",
        email: "stephen@ds",
        avatar: UIImage(named: "stephen")!, 
        editAction: {}
    )
}
