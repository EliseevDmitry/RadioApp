//
//  ProfileButton.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 29.07.2024.
//

import SwiftUI

struct CustomButton: View {
    
    enum ButtonType {
        case profile
        case onboarding
    }
    
    private enum Drawing {
        static let profileCornerRadius: CGFloat = 32
        static let onboardingCornerRadius: CGFloat = 0
        static let profileBackground: Color = DS.Colors.blueNeon
        static let onboardingBackground: Color = DS.Colors.pinkNeon
        static let textColor: Color = .white
    }
    
    let action: () -> Void
    let title: String
    let buttonType: ButtonType
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .foregroundColor(Drawing.textColor)
                .font(.custom(.sfRegular, size: 25))
                .padding()
                .background(
                    buttonType == .profile
                    ? Drawing.profileBackground
                    : Drawing.onboardingBackground
                )
                .clipShape(RoundedRectangle(cornerRadius:
                    buttonType == .profile
                    ? Drawing.profileCornerRadius
                    : Drawing.onboardingCornerRadius
                )
            )
        }
    }
}

#Preview {
    CustomButton(action: {}, title: "Sing Out", buttonType: .onboarding)
}
