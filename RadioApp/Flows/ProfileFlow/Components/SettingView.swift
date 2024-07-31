//
//  SettingView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 30.07.2024.
//

import SwiftUI

struct SettingView<Destination: View>: View {
    // MARK: - Properties
    var generalTitle: String
    
    var destinationTitleFirst: String
    var destinationFirst: Destination
    var imageIconFirst: String
    
    var destinationTitleSecond: String
    var destinationSecond: Destination
    var imageIconSecond: String
    
    // MARK: - Drawing Constants
    private struct Drawing {
        let titleFontSize: CGFloat = 18
        let titlePadding: CGFloat = 16
        let dividerPadding: CGFloat = 16
        let cornerRadius: CGFloat = 16
        let strokeWidth: CGFloat = 1.0
        let strokeOpacity: CGFloat = 0.2
        let dividerOpacity: CGFloat = 0.3
    }
    
    private let drawing = Drawing()
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - Title
            HStack {
                Text(generalTitle)
                    .padding()
                    .font(
                        .custom(
                            .sfBold,
                            size: drawing.titleFontSize
                        )
                    )
                    .foregroundColor(.white)
                    .padding(.leading, drawing.titlePadding)
                Spacer()
            }
            
            // MARK: - Settings Buttons
            SettingsButton(
                imageIcon: imageIconFirst,
                titleText: destinationTitleFirst,
                destination: destinationFirst
            )
            
            Divider()
                .background(.gray)
                .padding(.horizontal, drawing.dividerPadding)
                .opacity(drawing.dividerOpacity)
            
            SettingsButton(
                imageIcon: imageIconSecond,
                titleText: destinationTitleSecond,
                destination: destinationSecond
            )
        }
        .background(DS.Colors.darkBlue)
        .cornerRadius(drawing.cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: drawing.cornerRadius)
                .stroke(Color.gray, lineWidth: drawing.strokeWidth)
                .opacity(drawing.strokeOpacity)
        }
    }
}

// MARK: - Preview
#Preview {
    SettingView(
        generalTitle: "General",
        destinationTitleFirst: "Natification",
        destinationFirst: LegalPoliciesView(),
        imageIconFirst: "notification",
        destinationTitleSecond: "Language",
        destinationSecond: LegalPoliciesView(),
        imageIconSecond: "globe"
    )
}
