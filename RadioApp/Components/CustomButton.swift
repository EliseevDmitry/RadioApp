//
//  ProfileButton.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 29.07.2024.
//

import SwiftUI

struct CustomButton: View {
    // MARK: - Button Type Enum
    enum ButtonType {
        case profile
        case onboarding
    }
    
    // MARK: - Drawing Constants
    private enum Drawing {
        static let profileCornerRadius: CGFloat = 32
        static let onboardingCornerRadius: CGFloat = 8
        static let profileBackground: Color = DS.Colors.blueNeon
        static let onboardingBackground: Color = DS.Colors.pinkNeon
        static let textColor: Color = .white
    }
    
    // MARK: - Properties
    let action: () -> Void
    let title: String
    let buttonType: ButtonType
    
    // MARK: - Body
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

// MARK: - Preview
#Preview {
    CustomButton(action: {}, title: "Sign Out", buttonType: .onboarding)
}
