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
    private struct Drawing {
        static let iconSize: CGFloat = 40
        static let iconPadding: CGFloat = 10
        static let textSize: CGFloat = 14
        static let buttonPadding: CGFloat = 10
        static let strokeWidth: CGFloat = 0.8
        static let cornerRadius: CGFloat = 10
        static let strokeOpacity: CGFloat = 0.3
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(imageIcon)
                .resizable()
                .frame(
                    width: Drawing.iconSize,
                    height: Drawing.iconSize
                )
                .padding(.leading, Drawing.iconPadding)
            Text(titleText)
                .font(Font.custom(.sfMedium, size: Drawing.textSize))
                .foregroundColor(.white)
                .padding()
            Spacer()
            ChevronCircleView()
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: Drawing.cornerRadius)
            .stroke(Color.gray, lineWidth: Drawing.strokeWidth)
            .opacity(Drawing.strokeOpacity)
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
