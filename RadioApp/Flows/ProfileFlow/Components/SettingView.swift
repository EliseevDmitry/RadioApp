//
//  SettingView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 30.07.2024.
//

import SwiftUI

// MARK: - SettingView
struct SettingView: View {
    // MARK: - Properties
    var generalTitle: String
    
    var firstTitle: String
    var firstImageIcon: String
    var firstDestination: AnyView
    
    var secondTitle: String
    var secondImageIcon: String
    var secondDestination: AnyView

    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let titleFontSize: CGFloat = 18
        static let titlePadding: CGFloat = 16
        static let dividerPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 16
        static let strokeWidth: CGFloat = 1.0
        static let strokeOpacity: CGFloat = 0.2
        static let dividerOpacity: CGFloat = 0.3
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - Title
            HStack {
                Text(generalTitle)
                    .padding()
                    .font(.custom(.sfBold, size: DrawingConstants.titleFontSize))
                    .foregroundColor(.white)
                    .padding(.leading, DrawingConstants.titlePadding)
                Spacer()
            }
            
            // MARK: - Settings Buttons
            NavigationLink(destination: firstDestination) {
                SettingsButton(
                    imageIcon: firstImageIcon,
                    titleText: firstTitle
                )
            }
            
            Divider()
                .background(.gray)
                .padding(.horizontal, DrawingConstants.dividerPadding)
                .opacity(DrawingConstants.dividerOpacity)
            
            NavigationLink(destination: secondDestination) {
                SettingsButton(
                    imageIcon: secondImageIcon,
                    titleText: secondTitle
                )
            }
        }
        .background(DS.Colors.darkBlue)
        .cornerRadius(DrawingConstants.cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                .stroke(Color.gray, lineWidth: DrawingConstants.strokeWidth)
                .opacity(DrawingConstants.strokeOpacity)
        }
    }
}

#Preview {
    SettingView(
        generalTitle: "General",
        firstTitle: "Notification",
        firstImageIcon: "notification",
        firstDestination: AnyView(LegalPoliciesView()),
        secondTitle: "Language",
        secondImageIcon: "globe",
        secondDestination:  AnyView(LegalPoliciesView()))
}
