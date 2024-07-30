//
//  SettingsButtonView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 30.07.2024.
//

import SwiftUI

struct SettingsButton: View {
    
    var imageIcon: String
    var titleText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageIcon)
                    .resizable()
                    .frame(
                        width: 24,
                        height: 24
                    )
                    .padding(.leading, 10)
                Text(titleText)
                    .font(Font.custom(.sfMedium, size: 14))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(DS.Colors.blueNeon)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(DS.Colors.darkBlue)
        }
    }
}

#Preview {
    SettingsButton(
        imageIcon: "Notification",
        titleText: "Notification",
        action: {}
    )
}
