//
//  SettingsButton.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 30.07.2024.
//

import SwiftUI

// MARK: - SettingsButton
struct SettingsButton: View {
    // MARK: - Properties
    var imageIcon: String
    var titleText: String
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let iconSize: CGFloat = 40
        static let iconPadding: CGFloat = 10
        static let textSize: CGFloat = 14
        static let buttonPadding: CGFloat = 10
        static let strokeWidth: CGFloat = 0.8
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(imageIcon)
                .resizable()
                .frame(
                    width: DrawingConstants.iconSize,
                    height: DrawingConstants.iconSize
                )
                .padding(.leading, DrawingConstants.iconPadding)
            Text(titleText)
                .font(Font.custom(.sfMedium, size: DrawingConstants.textSize))
                .foregroundColor(.white)
                .padding()
            Spacer()
            ChevronCircleView()

        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                               .stroke(Color.gray, lineWidth: DrawingConstants.strokeWidth)
                    )
    }
    }

// MARK: - Preview
#Preview {
    SettingsButton(
        imageIcon: "notification",
        titleText: "Notification"
    )
}
