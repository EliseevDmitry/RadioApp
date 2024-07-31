//
//  SettingsButton.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 30.07.2024.
//

import SwiftUI

struct SettingsButton<Destination: View>: View {
    // MARK: - Properties
    var imageIcon: String
    var titleText: String
    var destination: Destination
    
    // MARK: - Drawing Constants
    private struct Drawing {
        let iconSize: CGFloat = 32
        let iconPadding: CGFloat = 10
        let textSize: CGFloat = 14
        let buttonPadding: CGFloat = 10
    }
    
    private let drawing = Drawing()
    
    // MARK: - Body
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(imageIcon)
                    .resizable()
                    .frame(
                        width: drawing.iconSize,
                        height: drawing.iconSize
                    )
                    .padding(.leading, drawing.iconPadding)
                Text(titleText)
                    .font(Font.custom(.sfMedium, size: drawing.textSize))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                ChevronCircleView()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(DS.Colors.darkBlue)
        }
    }
}

// MARK: - Preview
#Preview {
    SettingsButton(
        imageIcon: "notification",
        titleText: "Notification",
        destination: WelcomeView()
    )
}
