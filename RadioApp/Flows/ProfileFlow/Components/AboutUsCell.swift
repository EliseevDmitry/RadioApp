//
//  AvatarInCyrcleView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 04.08.2024.
//

import SwiftUI

// MARK: - AvatarInCyrcleView
struct AboutUsCell: View {
    // MARK: - Properties
    let name: String
    let gitURL: String
    var avatar: UIImage
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let borderWidth: CGFloat = 0.5
        static let borderColor = Color.gray
        static let avatarSize: CGFloat = 80
        static let verticalPadding: CGFloat = 10
        static let horizontalPadding: CGFloat = 10
        static let nameFontSize: CGFloat = 20
        static let gitFontSize: CGFloat = 12
        static let cornerRadius: CGFloat = 12
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            // MARK: - Avatar Section
            Image(uiImage: avatar)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: Drawing.avatarSize, height: Drawing.avatarSize)
                .overlay(
                    Circle()
                        .stroke(Drawing.borderColor, lineWidth: Drawing.borderWidth)
                )
            
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundColor(.white)
                    .font(.custom(DS.Fonts.sfBold, size: Drawing.nameFontSize))
                    .padding(.bottom, 4)
                Link(gitURL, destination: URL(string: gitURL)!)
                    .foregroundColor(DS.Colors.blueNeon)
                    .font(.custom(DS.Fonts.sfBold, size: Drawing.gitFontSize))
            }
            .padding(.leading, Drawing.horizontalPadding)
            Spacer()
        }
        .padding(.vertical, Drawing.verticalPadding)
        .background(Color.clear)
        .cornerRadius(CGFloat(Drawing.cornerRadius))
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview
#Preview {
    AboutUsCell(
        name: "Stephen",
        gitURL: "https://github.com/stephen",
        avatar: UIImage(named: "stephen")!
    )
}
