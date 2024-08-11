//
//  SettingView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 30.07.2024.
//

import SwiftUI

// MARK: - SettingView
struct SettingView<S, F>: View where S: View, F: View {
    // MARK: - Properties
    var generalTitle: String
    
    var firstTitle: String
    var firstImageIcon: String
    var settingsRoute: () -> S
    
    var secondTitle: String
    var secondImageIcon: String
    var secondSettingsRoute: () -> F

    // MARK: - Drawing Constants
    private struct DrawingConstants {
        let titleFontSize: CGFloat = 22
        let titlePadding: CGFloat = 16
        let dividerPadding: CGFloat = 16
        let cornerRadius: CGFloat = 16
        let strokeWidth: CGFloat = 1.0
        let strokeOpacity: CGFloat = 0.3
        let dividerOpacity: CGFloat = 0.3
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - Title
            HStack {
                Text(generalTitle)
                    .padding()
                    .font(.custom(.sfBold, size: DrawingConstants().titleFontSize))
                    .foregroundColor(.white)
                    .padding(.leading, DrawingConstants().titlePadding)
                Spacer()
            }
            
            // MARK: - Settings Buttons
            NavigationLink(destination: settingsRoute) {
                SettingsButton(
                    imageIcon: firstImageIcon,
                    titleText: firstTitle
                )
            }
            
            Divider()
                .background(.gray)
                .padding(.horizontal, DrawingConstants().dividerPadding)
                .opacity(DrawingConstants().dividerOpacity)
            
            NavigationLink(destination: secondSettingsRoute) {
                SettingsButton(
                    imageIcon: secondImageIcon,
                    titleText: secondTitle
                )
            }
        }
        .padding()
        .background(.clear)
        .cornerRadius(DrawingConstants().cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: DrawingConstants().cornerRadius)
                .stroke(Color.gray, lineWidth: DrawingConstants().strokeWidth)
                .opacity(DrawingConstants().strokeOpacity)
        }
    }
}

#Preview {
    SettingView(
        generalTitle: "General",
        firstTitle: "Notification",
        firstImageIcon: "notification",
        settingsRoute: LegalPoliciesView.init,
        secondTitle: "Language",
        secondImageIcon: "globe",
        secondSettingsRoute:  LegalPoliciesView.init
    )
}
