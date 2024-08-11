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
        case authentication
    }
    
    // MARK: - Drawing Constants
    private enum Drawing {
        static let profileCornerRadius: CGFloat = 32
        static let onboardingCornerRadius: CGFloat = 8
        static let authenticationCornerRadius: CGFloat = 0
        static let profileBackground: Color = DS.Colors.blueNeon
        static let onboardingBackground: Color = DS.Colors.pinkNeon
        static let authenticationBackground = DS.Colors.blueNeon
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
                .background(setBackground(for: buttonType))
                .clipShape(RoundedRectangle(cornerRadius: setCornerRadius(for: buttonType))
            )
        }
    }
    
    // MARK: - Private Methods
    private func setBackground(for buttonType: ButtonType) -> Color {
        switch buttonType {
        case .profile: 
            return Drawing.profileBackground
        case .onboarding:
            return Drawing.onboardingBackground
        case .authentication:
            return Drawing.authenticationBackground
        }
    }
    
    private func setCornerRadius(for buttonType: ButtonType) -> CGFloat {
        switch buttonType {
        case .profile:
            return Drawing.profileCornerRadius
        case .onboarding:
            return Drawing.onboardingCornerRadius
        case .authentication:
            return Drawing.authenticationCornerRadius
        }
    }
}



// MARK: - Preview
#Preview {
    CustomButton(action: {}, title: "Sign Out", buttonType: .onboarding)
}
